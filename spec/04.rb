require './spec_helper'

describe Library do

  subject!(:library) { FactoryGirl.create :library }
  let!(:library2) { FactoryGirl.create :library, name: 'Library' }
  let!(:book1) { FactoryGirl.create :book, library: library }
  let!(:book2) { FactoryGirl.create :book, library: library }
  let!(:book_for_another_library) { FactoryGirl.create :book, library: library2 }

  describe '#destroy' do
    it "also destroys the books once the library is destroyed" do
      library.destroy

      Book.find_by_id(book1.id).should be_nil
      Book.find_by_id(book2.id).should be_nil
      Book.find_by_id(book_for_another_library.id).should be_a(Book)
    end
  end

end
