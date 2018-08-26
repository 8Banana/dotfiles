import types

import curio

from packer import Packer


class Computer:

    _GUID_SEP = '0x27177c1797dc03ee853922f411bdf83f55e9ed2dcd953a4369f9b1a454e60fa0'.encode('utf-8')

    def __init__(self, p, host, port):
        self.p = p
        self.sock = None
        self.host = host
        self.port = port

    def __hash__(self):
        return hash(id(self) + self.port)

    async def impart_code(self, *args, pre_run=None):
        # multi module support
        modules = self.p.prepare()
        len_of_modules = len(modules).to_bytes(64, 'big')
        await self.send(len_of_modules)
        await self.send(modules)

    async def impart_data(self):
        data = self.p.prepare_data(self)
        len_of_data = len(data).to_bytes(64, 'big')
        await self.send(len_of_data)
        await self.send(data)

    @staticmethod
    def combine(*args):
        result = bytearray()
        for arg in args:
            try:
                arg = arg.encode('utf-8')
            except AttributeError:
                pass
            result += arg
        return result

    def reflect(self):
        pass

    def clear_callables(self):
        pass

    def run(self):
        pass

    async def start(self):
        if self.sock is None:
            await self.connect()
        await self.impart_code()
        await self.wait_for_pulse()
        await self.impart_data()
        await self.wait_for_pulse()
        await self.pulse()
        print(await self.recv())

    def wait(self):
        pass

    async def connect(self):
        self.sock = await curio.open_connection(self.host, self.port)

    def disconnect(self):
        self.sock.close()

    async def send(self, *args, **kwargs):
        await self.sock.send(*args, **kwargs)

    async def recv(self):
        buffer = bytearray()
        while True:
            d = await self.sock.recv(4096)
            if d == b'wololoo':
                return d
            elif d == b'':
                return buffer
            else:
                buffer += d

    async def pulse(self):
        await self.send(len(b'wololoo').to_bytes(64, 'big'))
        await self.send(b'wololoo')

    async def wait_for_pulse(self):
        p = await self.recv()
        assert(p == b'wololoo')
