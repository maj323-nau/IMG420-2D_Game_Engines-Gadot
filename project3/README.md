## Flocking (Boids) — integration
This assignment implements Craig Reynolds' Boids algorithm (separation, alignment, cohesion) in 2D using Godot 4.
A `Flock` manager spawns `Boid` instances and supplies neighbor queries. Each boid computes separation,
alignment, and cohesion steering vectors every physics frame; the resulting emergent behavior produces
natural-looking flocking. The system is tunable via exported parameters (radii, weights, speeds). 

In the final demo
I added a mechanic where the flock chases the player for a short period when triggered — this creates tension
and illustrates how emergent motion can be used as an enemy / hazard mechanic.

