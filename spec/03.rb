require './spec_helper'

describe Book do

  subject(:book) { FactoryGirl.build :book }

  describe '#title' do
    it "is required" do
      book.title = nil
      book.should_not be_valid
      book.errors[:title].should == ["can't be blank"]
    end

    it "is a max of 500 characters" do
      book.title = 'a' * 501
      book.should_not be_valid
      book.errors[:title].should == ["is too long (maximum is 500 characters)"]
    end
  end

	describe '#author' do
		it "is required" do
			book.author = nil
			book.should_not be_valid
			expect(book.errors[:author]).to include "can't be blank"
		end

		it "should be between 5 and 100 characters in length" do
			book.author = "A B"
			book.should_not be_valid
			book.errors[:author].should == ["is too short (minimum is 5 characters)"]
		end

		it "should be between 5 and 100 characters in length" do
			book.author = "A" * 101
			book.should_not be_valid
			book.errors[:author].should == ["is too long (maximum is 100 characters)"]
		end
	end

  describe '#pages' do
    it "is required (as a number)" do
      book.pages = nil
      book.should_not be_valid
      book.errors[:pages].should == ["is not a number"]
    end

    it "must be at least 4 (otherwise it's a pamphlet, not a book" do
      book.pages = 3
      book.should_not be_valid
      book.errors[:pages].should == ["must be greater than or equal to 4"]
    end

  end

end
