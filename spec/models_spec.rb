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

describe Shakespeare do
  describe 'generating with one monkey' do
    it "segregates the results into worthy and unworthy words" do
      mock_monkey = double("Monkey", :generate_words => ["to", "be", 'foo', 'bar'])
      Monkey.stub(:new) { mock_monkey }
      shakespeare = Shakespeare.new
      worthy_words, unworthy_words = shakespeare.write_with_one_monkey

      worthy_words.should == ["to", "be"]
      unworthy_words.should == ["foo", "bar"]
    end
    it "returns empty arrays if there are no matches" do
      mock_monkey = double("Monkey", :generate_words => [])
      Monkey.stub(:new) { mock_monkey }
      shakespeare = Shakespeare.new
      worthy_words, unworthy_words = shakespeare.write_with_one_monkey

      worthy_words.should == []
      unworthy_words.should == []
    end
  end
end

