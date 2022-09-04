require 'yaml'
# Define game class
class Game
  attr_accessor :secret_word, :guess_word, :wrong_guesses, :number_of_guess

  def initialize(secret_word, guess_word, wrong_guesses, number_of_guess)
    @secret_word = secret_word
    @guess_word = guess_word
    @wrong_guesses = wrong_guesses
    @number_of_guess = number_of_guess
    @game_over = false
    play_game
  end


  def play_game
    until @game_over
      # Ask the player to enter a letter and option to quit and save the game
      puts 'Enter a guess letter:  or  type exit to save and quit the game'
      @guess_char = $stdin.gets.chomp

      if @guess_char == 'exit'
        puts "save the current game"
        # p YAML::dump(self)
        save_game(self)
        @game_over = true

      elsif @guess_word.eql?(@secret_word.chomp)
        puts "Congratulations, You find the secret word #{@guess_word}"
        @game_over = true

      elsif @secret_word.include?(@guess_char)
        @secret_word.each_char.with_index {
          |char, i| @guess_word[i] = @guess_char if char == @guess_char
        }
        puts "Correct guesses #{@guess_word}"
        puts "Wrong guesses #{@wrong_guesses.join(' ')}"
        puts "#{@number_of_guess} chances left"
      else
        @wrong_guesses.push(@guess_char)
        @number_of_guess -= 1
        @game_over = true if @number_of_guess.zero?
        puts "Correct guesses #{@guess_word}"
        puts "Wrong guesses #{@wrong_guesses.join(' ')}"
        puts "#{@number_of_guess} chances left"
        puts 'Sorry, you lose...' if @number_of_guess.zero?
      end
    end
  end
end

def save_game(game)
  # Enter the name for the saved game
  puts 'Enter a name for your game'
  filename = gets.chomp
  dirname = 'saved'

  # Serialized game into the file 
  serialized_game = YAML::dump(game)

  # Create a new file in the saved directory and write the serilized game into it
  Dir.mkdir(dirname) unless File.exist? dirname
  File.open("#{dirname}/#{filename}.yaml", 'w') { |f| f.write(serialized_game) }
end
