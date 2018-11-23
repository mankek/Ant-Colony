#!/usr/bin/python
import random

# TODO: rather than hard-coded colors, allow for input of array of colors
# TODO: Introduce random death occurrence
# TODO: D3 animated chart of positions and cycles


# Initializes the input number of ants with specified colors
def get_ants(num_blue, num_green, position_range):
    ants = {}
    for s in range(0, num_blue + 1):
        ants["ant_" + str(s)] = {'position': random.randint(0, position_range), 'color': 'blue', 'colors': []}
    for t in range(s, s + num_green):
        ants["ant_" + str(t)] = {'position': random.randint(0, position_range), 'color': 'green', 'colors': []}
    return ants, position_range


test_ants, pos_range = get_ants(5, 5, 5)


# Each cycle each ant moves either up, down, left, right, or diagonally
def cycle_ants(cycles, ants, position_range):
    position_history = {}
    for i in range(0, cycles):
        position_history["cycle_" + str(i)] = {}
        for s in ants:
            # Defines the surrounding area of an ant
            surrounding_area = [ants[s]['position']]
            for t in [position_range+1, position_range, position_range-1, 1]:
                if (ants[s]['position']-t) < 0:
                    continue
                elif (ants[s]['position']+t) > (position_range*position_range):
                    continue
                else:
                    surrounding_area.append(ants[s]['position'] - t)
                    surrounding_area.append(ants[s]['position'] + t)
            # Randomly selects a new position
            print(surrounding_area)
            ants[s]['position'] = random.choice(surrounding_area)
            position_history["cycle_" + str(i)][s] = ants[s]['position']
    return ants, position_history


print(cycle_ants(5, test_ants, pos_range))

    #     # Checks if ants have met and records color if they have
    #     for t in range(0, len(ants)):
    #         for u in range(0, len(ants)):
    #             if t == u:
    #                 continue
    #             else:
    #                 if ants[t]['position'] == ants[u]['position']:
    #                     ants[t]['colors'].append(ants[u]['color'])
    #                     ants[u]['colors'].append(ants[t]['color'])
    #     changes = meeting_results(ants)
    #     changes_per_cycle.append({'cycle': i, 'changes': changes})
    # # Show ending distribution of ants
    # Green = 0
    # Blue = 0
    # for v in ants:
    #     if ants[v]['color'] == 'green':
    #         Green += 1
    #     elif ants[v]['color'] == 'blue':
    #         Blue += 1
    # # print(position_history)
    # return Blue, Green, changes_per_cycle, position_history


# If ants have met, records color of ant that was met
def meeting_results(ants):
    changes = []
    for i in ants:
        green = 0
        blue = 0
        for s in ants[i]['colors']:
            if s == 'green':
                green += 1
            elif s == 'blue':
                blue += 1
        resp = color_response(green, blue, i, ants)
        if resp != '':
            changes.append({i: resp})
    return changes


# Determines if ant changes color in response to ants it's met
def color_response(green, blue, ant_id, ants):
    if (green >= 5) and (blue < 5):
        if ants[ant_id]['color'] == 'blue':
            return ''
        else:
            # print(str(ant_id) + ' original color: ' + str(ants[ant_id]['color']))
            ants[ant_id]['color'] = 'blue'
            return 'color changed to blue'
    elif (green < 5) and (blue >= 5):
        if ants[ant_id]['color'] == 'green':
            return ''
        else:
            # print(str(ant_id) + ' original color: ' + str(ants[ant_id]['color']))
            ants[ant_id]['color'] = 'green'
            return 'color changed to green'
    else:
        return ''




