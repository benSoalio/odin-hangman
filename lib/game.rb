class Game

  def initialize
    @secret_word = generate_secret_word('google-10000-english-no-swears.txt').chomp
    @guess_word = ''
    @secret_word.each_char { |char| @guess_word << '_'}
    @wrong_guesses = []
    @number_of_guess = 10
    @game_over = false
    play_game 
  end

  # Generate a secret number
  def generate_secret_word(filename)
    # Read the google english no swear and keep the word between 5 and 12 characters
    words = File.readlines(filename).select { |word| word.length > 5 && word.length < 13}
    # Randomly select a word
    words.sample
  end

  def play_game
    until @game_over
      if @guess_word.eql?(@secret_word.chomp)
      puts "Congratulations, You find the secret word #{@guess_word}"
      @game_over = true
      end

      # Ask the player to enter a letter and option to quit and save the game
      puts 'Enter a guess letter:  or  type exit to save and quit the game'
      @guess_char = $stdin.gets.chomp

      if @guess_char == 'exit'
        puts 'save the game'
        @game_over = true

      elsif @secret_word.include?(@guess_char)
        @secret_word.each_char.with_index { 
          |char, i | @guess_word[i] = @guess_char if char == @guess_char
        }
        puts "Correct guesses #{@guess_word}" 
      else
        @wrong_guesses.push(@guess_char)
        @number_of_guess -= 1
        @game_over = true if @number_of_guess.zero?
        puts "Wrong guesses #{@wrong_guesses.join(' ')}"
        puts "#{@number_of_guess} chances left"
        puts 'Sorry, you lose...' if @number_of_guess.zero?
      end
    end    
  end


  
end
