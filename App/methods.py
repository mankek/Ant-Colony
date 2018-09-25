#!/usr/bin/python
import random

ants = {}


def get_ants(num_blue, num_green):
    for s in range(0, num_blue + 1):
        ants[s] = {'position': 0, 'color': 'blue', 'colors': []}
    for t in range(s, s + num_green + 1):
        ants[t] = {'position': 0, 'color': 'green', 'colors': []}
    return print('get_ants done!')


def cycle_ants(cycles, position_range):
    for i in range(0, cycles + 1):
        for s in ants:
            ants[s]['position'] = random.randint(0, position_range)
        for t in range(0, len(ants)):
            for u in range(0, len(ants)):
                if t == u:
                    continue
                else:
                    if ants[t]['position'] == ants[u]['position']:
                        ants[t]['colors'].append(ants[u]['color'])
                        ants[u]['colors'].append(ants[t]['color'])
        meeting_results()
    return print('cycle_ants done')


def meeting_results():
    for i in ants:
        green = 0
        blue = 0
        for s in ants[i]['colors']:
            if s == 'green':
                green += 1
            elif s == 'blue':
                blue += 1
        resp = color_response(green, blue, i)
        print(str(i) + ' Green: ' + str(green))
        print(str(i) + ' Blue: ' + str(blue))
        print(resp)
    return print('meeting_results done!')


def color_response(green, blue, ant_id):
    if (green >= 5) and (blue < 5):
        if ants[ant_id]['color'] == 'blue':
            return 'color unchanged'
        else:
            ants[ant_id]['color'] = 'blue'
            return 'color changed to blue'
    elif (green < 5) and (blue >= 5):
        if ants[ant_id]['color'] == 'green':
            return 'color unchanged'
        else:
            ants[ant_id]['color'] = 'green'
            return 'color changed to green'
    else:
        return 'color unchanged'


get_ants(num_blue=4, num_green=6)
cycle_ants(5, 10)


