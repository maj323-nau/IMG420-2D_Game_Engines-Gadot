## Flocking Integration

This project implements **Craig Reynolds’ Boids algorithm** to create realistic flocking behavior for a group of sci-fi ships. Each ship (boid) follows the classic three rules of **separation**, **alignment**, and **cohesion**, with tuned weights to achieve smooth, unified motion.  

The flock dynamically reacts to nearby neighbors, maintaining personal space while still aligning and moving as one coordinated group. Subtle random variation was added to prevent robotic movement, and a lightweight **leader-follow mechanic** ensures that the flock moves with cohesive direction and purpose. Edge wrapping was also implemented to keep the ships continuously visible within the play area.  

Flocking enhances the game’s design by adding **lifelike group motion** that feels natural and immersive. It gives the impression of intelligent, reactive entities and adds visual depth. 
This emergent movement creates a more engaging experience, making the world feel alive without requiring complex scripting or pathfinding systems.


**To the TA** 
It may vary in time how long the Boids group into one unit depending on how they spawn so just give it 20s.

Additonally, The game has elements to chase a player around the demo, however I wasn't able to implement this feature entirely.
You will see that in Flock.gd, there is a chase state for chasing the player as well as a timer for how long they chase and a target node.


