#!/usr/bin/ruby
require "yaml"

class Game

  @@file_dictionary = "5desk.txt"
  @@file_to_save_and_load_game = "hangman.yml"
  @@game_loaded = false

  def initialize
    @secret_word = ""
    @secret_word_dashes = ""
    @game_over = false
    @wrong_guesses_left = 7
    @letters_not_included = []
  end

  def play
    if @@game_loaded === false
      chose_secret_word
    end

    puts "Wrong guesses left: #{@wrong_guesses_left}"
    puts "Letters not included: #{@letters_not_included.join("")}"

    while @game_over === false do
      print_dashes
      guess
      check_game_over
    end
  end

  def self.load_game
    @@game_loaded = true
    YAML.load_file(@@file_to_save_and_load_game)
  end

  private

  def chose_secret_word
    words = File.readlines @@file_dictionary
    secret_word_length = 0
    while secret_word_length < 5 || secret_word_length > 12 do
      @secret_word = words[rand(words.length)].strip.downcase
      secret_word_length = @secret_word.length
    end
  end

 def print_dashes
      if @secret_word_dashes.length === 0
        (1..@secret_word.length).each {|i| @secret_word_dashes += "_"}
      end
      puts @secret_word_dashes
 end

 def guess
   letter_included = false
   puts ""
   puts "If you want to guess the whole word press enter otherwise guess the next letter or type 'save' to save the game."
   guessed_letter = gets.chomp
   if guessed_letter === ""
     guess_whole_word
     abort
   elsif guessed_letter === "save"
     save_game
     abort
   end
   guessed_letter = guessed_letter.downcase[0]
   secret_word_array = @secret_word.split("")
   secret_word_array.each_with_index do |letter, indx|
    if letter === guessed_letter
       @secret_word_dashes[indx] = letter
       letter_included = true
    end
   end
   if letter_included === false
     @wrong_guesses_left -= 1
     if !@letters_not_included.include? guessed_letter
       @letters_not_included = @letters_not_included.push(guessed_letter)
     end
   end
   puts "Wrong guesses left: #{@wrong_guesses_left}"
   puts "Letters not included: #{@letters_not_included.join("")}"
 end

 def guess_whole_word
   puts "Please guess the whole word:"
   guessed_word = gets.chomp
   guessed_word = guessed_word.downcase
   puts "Game over!"
   if guessed_word === @secret_word
     puts "You are the winner!"
     puts "You guessed the word correctly: #{@secret_word}."
   else
     puts "You lost!"
     puts "The word is #{@secret_word}."
   end
 end

 def check_game_over
   if @wrong_guesses_left === 0
     @game_over = true
     puts "Game over!"
     puts "You lost!"
     puts "The word is #{@secret_word}."
   end
   if !@secret_word_dashes.include? "_"
     @game_over = true
     puts "Game over!"
     puts "You are the winner!"
     puts "The word is #{@secret_word}."
   end
 end

 def save_game
   file = File.open(@@file_to_save_and_load_game, "w")
   file.puts YAML::dump(self)
   file.close
   puts "Game saved to #{@@file_to_save_and_load_game}."
 end

end

puts "Do you want to load an existing game? If yes, please type 'load' otherwise press enter."
option = gets.chomp
if option === "load"
  g = Game.load_game
  puts "Game loaded."
else
  g = Game.new
end
g.play
