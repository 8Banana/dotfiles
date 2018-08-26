import curio

from multicomputering import Computer, Packer, create_pool, map_data_to_pool


pkr = Packer()


@pkr.package('nonsense')
class IDoNothing:
    def __init__(self):
        self.wat = 'lol'

    @staticmethod
    def toot():
        return 'toot'


@pkr.package('nonsense')
def len_of_str(s):
    return len(s)


@pkr.package('main')
def main():
    import time
    from nonsense import len_of_str, IDoNothing
    time.sleep(1)
    return str(len_of_str(IDoNothing.toot()))


async def run():
    locations = [('localhost', 25001), ('localhost', 25002)]
    data = [{'blah': 'test string'}, {'blah': 'wololoo wololoo'}]

    poopers = create_pool(pkr, locations)  # not a real pool
    map_data_to_pool(pkr, poopers, data)

    # This is a bit manual atm, how 'n ever;
    async with curio.TaskGroup() as g:
        for pooper in poopers:
            await g.spawn(pooper.start())
    await g.join()


curio.run(run)
