require './dictionary'
require './guess'

class Wordle
  DEFAULT_WORD_LENGTH = 5
  DEFAULT_MAXIMUM_GUESSES = 6

  attr_accessor :word_length, :dictionary, :hidden_word, :guesses

  # Used when the supplied guess is the wrong size for the word
  class InvalidGuessLengthError < StandardError; end

  # Used when the supplied guess is not a valid dictionary word
  class InvalidGuessError < StandardError; end

  # Used when guesses are made but the wordle has been failed
  class FailedWordleError < StandardError; end

  # @param word_length [Integer] the number of letters in the word
  # @param maximum_guesses [Integer] the maximum number of guesses allowed
  def initialize(
    word_length = DEFAULT_WORD_LENGTH,
    maximum_guesses = DEFAULT_MAXIMUM_GUESSES
  )
    @word_length = word_length
    @maximum_guesses = maximum_guesses
    @dictionary = Dictionary.new
    @hidden_word = @dictionary.random_word_of_length(word_length)
    @guesses = []
  end

  def guess(word)
    raise InvalidGuessLengthError if word.length != @word_length
    raise InvalidGuessError unless dictionary.valid?(word)
    raise FailedWordleError unless @guesses.length < @maximum_guesses

    new_guess = Guess.new(word, @hidden_word)
    @guesses << new_guess

    puts new_guess.pretty_analysis
    new_guess.analysis
  end

  private

  def guessed_correctly?
    @guesses.any?(&:correct?)
  end
end
