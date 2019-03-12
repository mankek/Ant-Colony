The purpose of this application is to emulate (in a very rudimentary fashion) some of the emergent behaviors of an ant colony; currently, the focus is on re-creating the behavior of individual ants when it comes to 
role-moderation. 

When an ant encounters another ant it remembers the role this ant plays and can keep track of how many ants it has encountered that have this role; if it notes that it has met a very low number of ants with a certain role it will change to assume that role. 

Within this program, since there are two roles, distinguished by color (blue and green).
Ants are moved randomly each cycle in a square area, the size of which is user-determined.

If two ants end up at the same position, eachr ecrods the color of the ant they met.
If the number of met ants of a certain color exceeds half the ant population and the number met of 
the other color is under half, the ant changes color. The record of ants met is restarted upon color change.

In addition to a stand-alone script (Script.py), this holds an R Shiny application in the Ant_Colony folder.
It can be run using RStudio or the console command:

```
shinyApp(ui = ui, server = server)
```

