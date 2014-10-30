require './spec_helper'

describe Book do

  subject(:book) { Book.new }
  let(:library) { Library.new }

  describe "associations" do
    it "should be able to get its library" do
      expect { book.library }.not_to raise_error
    end

    it "should be able to set its library" do
      expect { book.library = library }.not_to raise_error
    end
  end

end

describe Library do

  subject(:library) { Library.new }

  describe "associations" do
    it "should be able to get its books" do
      expect { library.books }.not_to raise_error
    end

    it "should be able to set its books" do
      expect { library.books.new }.not_to raise_error
    end
  end

end
