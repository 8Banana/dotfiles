import os
import pathlib
import shutil
import stat
import sys
import time

import types
from enum import Enum, auto
import importlib.util

import socket
import json

from multicomputering import Packer


class WorkerStates(Enum):
    Listening = auto()
    Connecting = auto()
    PreparingWork = auto()
    Working = auto()


class ComputerWorker:

    _GUID_SEP = '0x27177c1797dc03ee853922f411bdf83f55e9ed2dcd953a4369f9b1a454e60fa0'.encode('utf-8')

    def __init__(self, sock):
        self.state = WorkerStates.Listening
        self.sock = sock
        self.workspace = {}
        self._loc = None
        self._packages_loc = None
        self.results = {}

    def ready_filesys(self, loc):
        self._loc = os.path.dirname(os.path.abspath(__file__))
        self._packages_loc = os.path.join(
            self._loc, '..', '.multicomputering_packages_' + str(id(self)))
        sys.path.append(loc or self._packages_loc)
        pathlib.Path(self._packages_loc).mkdir(parents=True, exist_ok=True)

    def clean_up_filesys(self):
        shutil.rmtree(self._packages_loc, onerror=self.remove_readonly)

    def start(self, loc=None):
        self.ready_filesys(loc)
        print('doing task :)')
        self.recv_init()
        self.recv_code()
        self.recv_data()
        self.wait_for_pulse()
        self.run()
        print('Done!')
        self.clean_up_filesys()
        self.disconnect()

    def recv_init(self):
        pass

    def recv_code(self, *args):
        data = self.recv()
        data = json.loads(data.decode('utf-8'))
        for module_name, contents in data.items():
            Packer.write_package(self._packages_loc, module_name, contents)
            self.workspace[module_name] = contents
        self.pulse()

    def recv_data(self, *args):
        data = self.recv()
        data = json.loads(data.decode('utf-8'))
        Packer.write_data(
            self._packages_loc, '_remote_data', data)
        self.pulse()

    def reflect(self):
        pass

    def clear_callables(self):
        pass

    def run(self):
        py_obj = importlib.util.spec_from_file_location(
            'main', os.path.join(
                self._packages_loc, 'main' + '.py'))
        module = importlib.util.module_from_spec(py_obj)
        py_obj.loader.exec_module(module)
        result = module.main()

        self.send(result.encode('utf-8'))

    def disconnect(self):
        self.sock.close()
        raise SystemExit(0)

    def send(self, *args, **kwargs):
        self.sock.sendall(*args, **kwargs)

    def recv(self):
        buffer = bytearray()
        while True:
            buffer += self.sock.recv(4096)
            if len(buffer) >= 64:
                bytes_target = int.from_bytes(buffer[:64], 'big')
                buffer = buffer[64:]
                break
        while len(buffer) != bytes_target:
            buffer += self.sock.recv(4096)
        return buffer

    def pulse(self):
        self.send(b'wololoo')

    def wait_for_pulse(self):
        p = self.recv()
        assert(p == b'wololoo')

    @staticmethod
    def remove_readonly(func, path, _):
        print(path)
        "Clear the readonly bit and reattempt the removal"
        os.chmod(path, stat.S_IWRITE)
        func(path)


def handler(sock, addr):
    pc = ComputerWorker(sock)
    try:
        pc.start()
    except KeyboardInterrupt as e:
        pc.clean_up_filesys()
        raise e



def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind(('localhost', int(sys.argv[1])))
    sock.listen(5)
    while True:
        (clientsock, address) = sock.accept()
        print("Got client!", address)
        handler(clientsock, address)


if __name__ == '__main__':
    main()
