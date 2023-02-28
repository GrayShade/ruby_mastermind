# ruby_mastermind

## Description:

This is an object oriented based game project completed in ruby as part of [The Odin Project](https://www.theodinproject.com/). At the time of writing, link for this particular project is [ruby-mastermind](https://www.theodinproject.com/lessons/ruby-mastermind). 

### How It Works:
This is basically a game about guessing the color. 6 colors array is given. Player is given a choice to be either code creator or breaker(guesser). If the player is a creator or guesser, then he chooses an array of 4 characters to be guessed by other player in 12 turns. Hints for correct elements on correct positions & correct elements on wrong positions are provided on each turn. Game is over if 12 turns are reached before guessing. 

### Structural Overview:
On the note of structure of project, it comprises of seven class files & one module file named as `utilmod.rb`. Module just contains a utility function. `board.rb` is used to display data on the console, `game.rb` is main code file. `player.rb` contains parent class of `ComputerPlayer` & `HumanPlayer` classes. Game is started via a `Game` class object. This class can access all other classes but no other class can access this class or other class directly. Controlling of project is done via `Game` class.

### Computer Thinking Logic:
As far as winning goes, It wins some & loses some. Losing ratio increases when all elements are random. Multiple same elements are more the merrier for computer player to guess. Winning ratio of computer player is quite satisfactory for me & am quite happy with it.
it boils down to many factors & code pieces but a pretty substantial way I use is described below.

Computer player when guessing, specifically checks for combinations resulting in hints array being `[4, 0], [0, 4] & [0, 0]`. If its first case, then all elements match, congrats to player won. In second case, it means all positions are wrong. Then these are stored against those elements & each generated random array is regenerated if contains either of those offending positions. In third case, as there is no match indicated by hints array, those elements are skipped from being in random array when generating one in next turn.  

## How To Run:
cd to project root directory via terminal or open terminal there pointing to root directory. In terminal, use:
```
ruby game.rb
```
## Future Ideas / Intentions:
Not in any specific order or final but:
1. Making a beautiful UI for playing game containing vibrant colors, more descriptive text etc.
2. Making computer player more competent than it currently is. At the time it is doing a pretty solid job, but can do better to further lessen its losing ratio.