require 'set'
require 'celluloid'

class Shakespeare
  VALID_WORDS = ["to", "be", "or", "not"]
  NUMBER_OF_MONKEYS = 10

  def write_with_monkeys(number_of_words_to_try)
    @monkeys ||= create_monkeys(NUMBER_OF_MONKEYS)
    words_per_monkey = number_of_words_to_try / NUMBER_OF_MONKEYS

    futures = @monkeys.map do |monkey|
      monkey.future(:generate_words, words_per_monkey)
    end

    reduce_to_word_set(word_sets_from_futures(futures)).partition { |word| VALID_WORDS.include? word }
  end

  private

  def create_monkeys(number_of_monkeys)
    monkeys = []
    number_of_monkeys.times do
      monkeys << Monkey.new
    end
    monkeys
  end

  def word_sets_from_futures(futures)
    futures.map { |future| future.value }
  end

  def reduce_to_word_set(array)
    array.reduce(Set.new) { |accumulator, set| accumulator.merge(set) }
  end
end

class Monkey
  include Celluloid
  VALID_LETTERS = ('a'..'z').to_a

  def generate_words(number_of_words)
    generated_words = Set.new

    number_of_words.times do
      generated_words.add(generate_word(Random.rand(10) + 1 ))
    end

    generated_words
  end

  private
  def generate_word(word_length)
    word = ""
    word_length.times do
      word << VALID_LETTERS[Random.rand(VALID_LETTERS.length)]
    end
    word
  end
end
