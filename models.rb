require 'set'

class Shakespeare
  VALID_WORDS = ["to", "be", "or", "not"]

  # Inputs:
  # number_of_monkeys: Integer - the number of monkeys to use to write your works
  def write_with_many_monkeys(number_of_monkeys)

  end

  def write_with_one_monkey
    monkey_words = Monkey.new.generate_words(100)
    monkey_words.partition { |word| VALID_WORDS.include? word  }
  end
end

class Monkey
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
