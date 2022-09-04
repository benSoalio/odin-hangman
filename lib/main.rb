require_relative 'game'
choice = 0
puts <<-WELCOME
  Welcome to hangman by COZAKH
WELCOME

# Generate a secret word
def generate_secret_word(filename)
  # Read the google english no swear and keep the word between 5 and 12 characters
  words = File.readlines(filename).select { |word| word.length > 5 && word.length < 13}
  # Randomly select a word
  words.sample
end

secret_word = generate_secret_word('google-10000-english-no-swears.txt').chomp
guess_word = ''
secret_word.each_char { |char| guess_word << '_'}
wrong_guesses = []
number_of_guess = 10


until choice == 1 || choice == 2
  puts 'press 1 to play a new game'
  puts 'press 2 to load a saved game'
  choice = gets.chomp.to_i
end

Game.new(secret_word, guess_word, wrong_guesses, number_of_guess)
