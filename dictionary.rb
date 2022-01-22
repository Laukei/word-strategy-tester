class Dictionary
  WORDLIST = 'wordlist.txt'

  # @return [Boolean] whether a word is legal
  def valid?(word)
    words_of_length(word.length).include?(word)
  end

  # @return [String] random word of specified length
  def random_word_of_length(length)
    words_of_length(length).sample
  end

  private

  # @return [Array<String>] array of words of specified length
  def words_of_length(length)
    return @words_of_length[length] if @words_of_length

    @words_of_length ||= all_words.group_by(&:length)
    @words_of_length[length]
  end

  # @return [Array<String>] array of all words
  def all_words
    @all_words ||= File.read(WORDLIST).split
  end
end
