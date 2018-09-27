#!/usr/bin/python
import random

# TODO: rather than hard-coded colors, allow for input of array of colors
# TODO: Introduce random death occurrence
# TODO: D3 animated chart of positions and cycles


# Initializes the input number of ants with specified colors
def get_ants(num_blue, num_green):
    ants = {}
    for s in range(0, num_blue + 1):
        ants[s] = {'position': 0, 'color': 'blue', 'colors': []}
    for t in range(s, s + num_green):
        ants[t] = {'position': 0, 'color': 'green', 'colors': []}
    return ants


# Each cycle each ant moves to a random position; checks if ants 'meet' (are at same position)
def cycle_ants(cycles, position_range, ants):
    position_history = {}
    changes_per_cycle = []
    for i in range(0, cycles):
        position_history[i] = {}
        for s in ants:
            ants[s]['position'] = random.randint(0, position_range)
            position_history[i][s] = ants[s]['position']
        for t in range(0, len(ants)):
            for u in range(0, len(ants)):
                if t == u:
                    continue
                else:
                    if ants[t]['position'] == ants[u]['position']:
                        ants[t]['colors'].append(ants[u]['color'])
                        ants[u]['colors'].append(ants[t]['color'])
        changes = meeting_results(ants)
        changes_per_cycle.append({'cycles': i, 'changes': changes})
    # Show ending distribution of ants
    Green = 0
    Blue = 0
    for v in ants:
        if ants[v]['color'] == 'green':
            Green += 1
        elif ants[v]['color'] == 'blue':
            Blue += 1
    # print(position_history)
    return Blue, Green, changes_per_cycle, position_history


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




