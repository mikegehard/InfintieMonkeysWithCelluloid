require 'set'
require 'celluloid'

class Shakespeare
  VALID_WORDS = ["to", "be", "or", "not"]

  # Inputs:
  # number_of_monkeys: Integer - the number of monkeys to use to write your works
  def write_with_monkeys(number_of_generators)

    generate_futures = []

    # you only need to create one of these and just ask it to do
    # things many times
    monkey = Monkey.new
    number_of_generators.times do
      generate_futures << monkey.future(:generate_words, 100)
    end

    reduce_to_word_set(word_sets_from_futures(generate_futures)).partition { |word| VALID_WORDS.include? word }
  end

  def write_with_one_monkey
    monkey_words = Monkey.new.generate_words(100)
    monkey_words.partition { |word| VALID_WORDS.include? word }
  end

  private
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
      generated_words.add(generate_word(Random.rand 1..10))
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
