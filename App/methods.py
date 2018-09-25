#!/usr/bin/python
import random

# TODO: rather than hard-coded colors, allow for input of array of colors
# TODO: Introduce random death occurrence


ants = {}


# Initializes the input number of ants with specified colors
def get_ants(num_blue, num_green):
    for s in range(0, num_blue + 1):
        ants[s] = {'position': 0, 'color': 'blue', 'colors': []}
    for t in range(s, s + num_green + 1):
        ants[t] = {'position': 0, 'color': 'green', 'colors': []}
    return print('get_ants done!')


# Each cycle each ant moves to a random position; checks if ants 'meet' (are at same position)
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
    # Show ending distribution of ants
    Green = 0
    Blue = 0
    for v in ants:
        if ants[v]['color'] == 'green':
            Green += 1
        elif ants[v]['color'] == 'blue':
            Blue += 1
    return print("Blue: " + str(Blue) + "\n" + "Green: " + str(Green))


# If ants have met, records color of ant that was met
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
        # print(str(i) + ' Green: ' + str(green))
        # print(str(i) + ' Blue: ' + str(blue))
        if resp != '':
            print(resp)


# Determines if ant changes color in response to ants it's met
def color_response(green, blue, ant_id):
    if (green >= 5) and (blue < 5):
        if ants[ant_id]['color'] == 'blue':
            return ''
        else:
            print(str(ant_id) + ' original color: ' + str(ants[ant_id]['color']))
            ants[ant_id]['color'] = 'blue'
            return 'color changed to blue'
    elif (green < 5) and (blue >= 5):
        if ants[ant_id]['color'] == 'green':
            return ''
        else:
            print(str(ant_id) + ' original color: ' + str(ants[ant_id]['color']))
            ants[ant_id]['color'] = 'green'
            return 'color changed to green'
    else:
        return ''


get_ants(num_blue=10, num_green=20)
cycle_ants(20, 10)


