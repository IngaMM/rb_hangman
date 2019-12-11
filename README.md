Hangman

By I. Mahle

A project of The Odin Project: https://www.theodinproject.com/courses/ruby-programming/lessons/file-i-o-and-serialization

Instructions

1. Change into the root directory of the project and type ./hangman.rb in the console
2. Follow the instructions

Discussion
I used the following technologies: Ruby with classes, methods and (de-)serialization.

This is a command line Hangman game where one player plays against the computer.
When a new game is started, the script loads in the dictionary and randomly selects a word between 5 and 12 characters long for the secret word. The count shows how many more incorrect guesses are left before the game ends. When out of guesses the player loses. Correct and incorrect letters are shown. The game is case insensitive. At the start of any turn, instead of making a guess the player has also the option to save the game. A saved game can be re-opened and continued.
