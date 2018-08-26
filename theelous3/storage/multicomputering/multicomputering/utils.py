from .computer import Computer


def create_pool(packer, list_of_locations):
    return [Computer(packer, *x) for x in list_of_locations]


def map_data_to_pool(pkr, pool, xs):
    for comp, x in zip(pool, xs):
        pkr.remote_data[comp] = x
