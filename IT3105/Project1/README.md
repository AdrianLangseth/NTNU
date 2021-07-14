# Assigment 1: Actor Critic model for Peg Solitaire
This is my solution for Assignment 1 in the course Artificial Intelligence programming. The solution contains a
implementation of the Peg solitaire game serving as the problem for the actor-critic model.


### File overview

- actor.py
- critic.py
- splitGD.py
- PegSolitaire.py
- main.py
- README.md

### Discussional topics

In the second course meeting, the course professor mentioned using a negative reward for all moves not directly 
resulting in a win. Although this is a good basis for general RL agents, in this field every win takes an equal amount 
of moves. Would it not therefore be as beneficial to give a positive reinforcement when any move is made because of 
penalizing an agent for using excessive moves would not have an effect for a more efficient solution as all solutions 
are equally efficient?