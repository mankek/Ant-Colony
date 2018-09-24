#!/usr/bin/python
import random
# Maybe contain all ants within 1 dictionary
ant_1 = {'color': 'blue', 'green_track': 0}
ant_2 = {'color': 'green', 'blue_track': 0}


def get_ants(cycles):
    for i in range(0, cycles + 1):
        ant_1['position'] = random.randint(0, 10)
        ant_2['position'] = random.randint(0, 10)
        if ant_1['position'] == ant_2['position']:
            ant_1['green_track'] = ant_1['green_track'] + 1
            ant_2['blue_track'] = ant_2['blue_track'] + 1
        else:
            continue
    return print(ant_1['green_track'], ant_2['blue_track'])


get_ants(cycles=15)

