require_relative '../models'

describe Monkey do
  describe 'generating words' do
    let(:monkey) { Monkey.new }
    it "returns me a set of words" do
      number_of_words_to_generate = 10

      # we may get duplicates
      monkey.generate_words(number_of_words_to_generate).length.should > 0
    end

    it "makes all of the returned words between 1 and 10 chars in length" do
      monkey.generate_words(100).all? { |word| word.length > 0 && word.length <= 10 }.should be_true
    end
  end
end

