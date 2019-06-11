The purpose of this application is to emulate (in a very rudimentary fashion) some of the emergent behaviors of an ant colony; currently, the focus is on re-creating the behavior of individual ants when it comes to 
role-moderation. 

When an ant encounters another ant it remembers the role this ant plays and can keep track of how many ants it has encountered that have this role; if it notes that it has met a very low number of ants with a certain role it will change to assume that role. 

Within this program, since there are two roles, distinguished by color (blue and green).
Ants are moved randomly each cycle within a square area, the size of which is user-determined.

If two ants end up at the same position, each records the color of the ant they met.
If the number of met ants of a certain color exceeds half the ant population and the number met of 
the other color is under half, the ant changes color. The record of ants met is restarted upon color change.

A variable of random death can also be introduced; this variable means that for each cycle, each ant will have a certain percent chance
of dying and being removed from the population. Since there is no 'birth' variable, even relatively low chances of death (5%) will cause the ant population to dwindle to nothing.

In addition to a stand-alone script (Script.py), this holds an R Shiny application in the Ant_Colony folder.
It can be run using RStudio or by navigating into the project directory and using the console command:

```
R -e shiny::runApp()
```

This will launch the application on a random port (if you want a specific port specify 'port = ####' inside the console command).

It will take a few moments for the graph to load.