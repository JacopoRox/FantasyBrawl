# Fantasy Brawl

## Video Demo:  <https://youtu.be/4tStpi74BCo>

### Game Description

#### Introduction

Fantasy Brawl is a fantasy *side-scrolling beat 'em up* game. I made this game as my [CS50](https://cs50.harvard.edu/x/2021/) final project. It was programmed using [Lua](https://www.lua.org) and [LÖVE](https://love2d.org) as framework. The idea behind the game is that of an infinite brawl where the player keeps fighting an horde of enemies generated by the game. There are no levels to explore but the difficulty of the game increases (up to level 7) with the amount of enemies you killed. Each killed enemy increase your score by 1 and the current score is displayed during each run, along with the level you currently reached. There are 3 different playable characters (Warrior, Huntress and Samurai) and a selection phase before each run allows the player to select one of them. Each run ends with the player death, the score obtained during the last run keeps getting displayed until a new run is initiated.

#### Download

You can download the game from [here](https://drive.google.com/file/d/1S5wQfL22Cm_Mc7xcHaygBOiZ86VovC2w/view?usp=sharing). Just unzip the folder and use the .exe file to run the game (you don't need to install LÖVE or anything else).

#### Commands

Here's the list of the commands to control your character:

- Move left: *left-arrow*
- Move right: *right-arrow*
- Jump: *up-arrow* or *spacebar*
- Attack: *S*
- Ranged attack: *D* **(Huntress only)**

#### Heroes

I made 3 playable characters and I tried to make them somewhat different from one another from a gameplay point of view. The warrior has the higher amount of strenght (he can oneshot the less resilient enemies) and has more life than the other heroes at the cost of a low attack speed. The samurai attacks really fast but could need a few hits to take down an enemy (expecially Mushrooms), more importantly he is the only character that is allowed to move during an attack making it possible for him to dodge and hit at the same time. Finally, the huntress has low damage output but she can shoot her lances from distance *kiting* enemies to death.

### Files Description

#### main.lua

The main file from which the game is loaded into the LÖVE framework. Here the Dependencies.lua file is loaded into memory (using the require function). The main file also defines 3 function: love.load, love.update and love.draw. These are default functions for LÖVE which respectively load a one time setup of the game, update the game each frame, and render the game to the screen (more [here](https://love2d.org/wiki/love)). In love.load the basic setup (like the dimensions of the window in which the game is going to be played) is handled but most importantly a global StateMachine is initiated, an object that allows the game to transition between its various phases dinamically. The background music is also initiated along with a couple of variables and a table that allows the game to keep track of what keys have been pressed each frame. In love.update and love.draw the current state of the game is respectively updated and rendered.

#### Dependencies.lua

This file is used to require all the libraries needed to make the game work. Along with that, it loads into memory all the assets (sprites, font and music) storing them into [tables](https://www.lua.org/pil/2.5.html). Finally, tables of [quads](https://love2d.org/wiki/Quad) defining specific frames are generated calling the GenerateQuads function definied in Util.lua

#### Util.lua

In this file utility functions are defined, in this case we only have the GenerateQuads function which takes a texture and the dimensions of the quads to be generated and return a table containing all the quads.

#### entity_defs.lua

Raw data defining the stats and flags of each specific Entity. I had to add some offset and scale values in order to make the rendering of every entity consistent.

#### object_defs.lua

Raw data defining the stats and flags of each specific game objects.

#### constants.lua

Global constants values (such as window width and height) are definied in this file.

#### class.lua

Used to implement the concept of class in Lua. I took this from the games in the game track of CS50 and used it as it was.

#### Animation.lua

A class used to render a specific frame of a texture and handle the transition between one frame and the next. This class stores a texture, a collection of frame along with variables used to keep track of time. In the Animation.update function if enough time has passed the variable currentFrame is increased, this is than used in the Animation.render function to index the frames table which contains the quads collection for a specific texture that is rendered to the screen using the [love.graphics.draw](https://love2d.org/wiki/love.graphics.draw) function. I found it useful to define an Animation.render function that calls the draw function passing in the texture and the quads stored into the animation itself, I thought that this way it would have been possible to handle the rendering from within the animation class without having to index the animation for its texture and quads each time you want to render a sprite to the screen. Animation.render takes an x and y along with scale factors as arguments in order to handle sprites flipping and scale adjustments.

#### Level.lua

A class that handles enemies spawning, keeps track of current level and score. All enemy entities are store in a table so that it is possible to iterate through it every frame in order to update and render all entities.

#### Box.lua

A class that generates a box definied by an x, a y, a width, and a height. The box can be updated and optionally rendered to the screen. Also contains an AABB collision detection function.

#### Background.lua

A class that holds function to handle background updating and rendering. All the parallax layers of the background are stored in a table that can be iterated for updating and rendering.

#### Entity.lua

This class is used to generate all the entities (enemies and player). It stores all the variables that keep track of each entity stats and flags. It also stores various entity-related function (e.g Entity.damage). Entity.update and Entity.render respectively update and render the entity current state to the screen along with handling some additional logic.

#### Hero.lua

A class that inherit from the Entity class. It handles projectiles differently and initiate a different state machine containing states that allows the hero character to be controlled by the player. This class also stores a group of input-related functions that are called within the hero's states to check wheter a certain key was pressed in a given frame. Calling this function makes the logic within the states less verbose.

#### Healthbar.lua

This class generates healthbar objects used to visually output the current health of the enemies and the player. Healthbar object are instanciated within every Entity and are updated according to the respective Entity x and y.

#### StateMachine.lua

A state machine class used to handle state transition. It stores a table containing functions that returns state objects when the StateMachine.change function is called, initiating all that is need to handle that specific state. The game itself has a state machine that switches between various phases of the game (e.g from the play-state to the gameover-state). Entities and the background also have a state machine that changes the behaviours of these elements when needed. The current state of any state machine is updated and rendered in the respective functions.

#### Projectile.lua

This class handle projectile stats initiation, logic and rendering. The logic for the projectile is so simple that I found it not worth to give them a state machine.

#### Camera.lua

A Camera class that fallows the player movement updating its own x accordingly. Its x is than passed to the love.graphics.translate function during the game making it so that the player is always in the middle of the screen. The player and the enemies are translated but not the background which simply scroll infinitly (games are illusions)

#### states

The state folder contains all the states used to build the various machines, all of them inherit from the BaseState which is a state with empty methods that avoids errors if a function is not defined but called in an actual state. Each group of states handle the logic for a specific entity (enemies and player), the background, or the game itself.
The background only has 2 states with the only differece being that in the BackgroundPlayState the scrolling fallows the player movement (the player is in fact an argument needed for entering the state) while in the BackgroundSelectionState it endlessly scrolls to the left of the screen.
Entities' states handle the logic to pilot the enemies. Entering a state switch the current animation of the entity in order to always display the correct one during any action. The idle state keeps the enemy on cooldown: a variable keeps track of the time based from when the state has been entered, if the time is equal to the rest time assignied to each specific enemy in entity_def.lua the entity changes its state. If the player is in range it attacks, else it enters the run state. Here entities behave differently depending on wheter they are aggressive or not: aggressive enemies always run towards the player, on the other hand a non-aggressive entity walks randomly across the map and goes back to the idle state after 1 second. Non-aggressive enemies still attack the player if it is in range at any time during the movement. When entering the attack state an hitbox is generated and updated but the collision with the player (simple AABB) is only checked after a certain frame is reached in the attack animation (definied in entity_defs.lua and dependent on the sprite of the attack animation) in order to make attacks more realistic and consistent with what is displayed on screen. If collision is detected player.damage is called and logic is applied.
Hero's states is where the inputs from the player are checked and the logic is applied coherently. In the idle, run falling and jumping states it is possible to move the hero left and right (player.moveRight and player.left are called) but only in the idle and running state it is possible to jump, preventing infinite jumping. Attack inputs (player.attack) are also checked and makes the hero enter its attack state which work pretty much like the other entities' attack state but with collision check on all enemies currently inside level.entities (which recall stores and update all enemies each frame).
Both enemies and the player go invulnerable after taking damage. Enemies stay invulnerable for the duration of the take hit state plus their rest time preventing them from taking damage while they are resting. The player instead, is invulnerable for 1 second which is a bit more of the duration of its take hit animation, allowing the player to reposition while still invulnerable and preventing him to be damaged from multiple sequential attacks.
An entity is flagged as dead at the end of its death animation. If dead, enemies get removed from the level.entities table: I could have simply prevent their rendering and updating after their death but I decided to remove them from the table to prevent memory wasting (long run could lead to the generation of lots of enemies). When the player itself is flagged as dead the global state machine state is changed to game-over and the run is over.
The global state machine is composed of 5 states, the start state initiate the background and waits for user inputs (Press enter to play is displayed). When enter is pressed the .change function is called (passing in the background so that it keeps scrolling) and we enter the selection state. Here I wanted to display every hero in their idle state but instead of actually initiating 3 objects from the Hero class I decided to only create 3 animation (again for memory sake) passing in the idle texture and the idle collection of frames of each specific character. A box object is initiated and rendered, it is possible to move it thanks to the selectionstate.movebox function which also update a variable called box.index that allows the box to keep track of what character it is highlighting. When the character is selected (by pressing enter) an actual Hero object is initiated and passed to the play state through the change function and a new run is initiated. At the end of it, from the game over state it is possible to go back to a new selection state in order to allow the changing of the character and start a new run.

### Credits

I would like to credit and thanks the authors of the amazing art I used to make Fantasy Brawl:

- Sprites: [LuizMelo](https://luizmelo.itch.io)
- Background: [Digital Moons](https://digitalmoons.itch.io)
- Music: Eric Skiff - Song Name - A Night Of Dizzy Spells - Available [here](https://EricSkiff.com/music)
- Font: [vrtxrry](https://vrtxrry.itch.io)
