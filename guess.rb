class Guess
  CORRECT = :correct
  WRONG_LOCATION = :wrong_location
  WRONG_LETTER = :wrong_letter

  def initialize(guessed_word, target_word)
    @guessed_word = guessed_word
    @target_word = target_word
  end

  def correct?
    @guessed_word == @target_word
  end

  def pretty_analysis
    colourstring = ''

    analysis.each do |result|
      colourstring +=
        case result
        when CORRECT
          '🟩'
        when WRONG_LOCATION
          '🟨'
        when WRONG_LETTER
          '⬜'
        end
    end

    "#{spaced_guess}\n#{colourstring}"
  end

  def spaced_guess
    return @spaced_guess if @spaced_guess

    @spaced_guess = ' '

    guessed_word_letters.each do |letter|
      @spaced_guess += "#{letter} "
    end

    @spaced_guess
  end

  def analysis
    @analysis ||= begin
      unused_letters = target_word_letters.dup

      letter_pairs.map do |guess, target|
        if guess == target
          unused_letters.delete_at(unused_letters.index(guess))
          CORRECT
        elsif guess != target && unused_letters.include?(guess)
          unused_letters.delete_at(unused_letters.index(guess))
          WRONG_LOCATION
        else
          WRONG_LETTER
        end
      end
    end
  end

  def letter_pairs
    guessed_word_letters.zip(target_word_letters)
  end

  def guessed_word_letters
    @guessed_word_letters ||= @guessed_word.split('')
  end

  def target_word_letters
    @target_word_letters ||= @target_word.split('')
  end
end
