require './spec_helper'

describe Library do

  subject!(:library) { FactoryGirl.create :library }
	let!(:library2) { FactoryGirl.create :library, name: 'Library' }
  let!(:book1) { FactoryGirl.build :book, library: library }
  let!(:book2) { FactoryGirl.build :book, library: library }
  let!(:book_for_another_library) { FactoryGirl.build :book, library: library2 }
	let!(:lend1) { FactoryGirl.build :lend, library: library, book: book1 }
	let!(:lend2) { FactoryGirl.build :overdue_lend, library: library, book: book2 }

  describe '#revenue' do
    it "is increased by a lending's late fees when a book is returned late" do
      library.revenue.should == 0
			library.late_fee = 20

      lend2.save

      library.reload.revenue.should == 140
    end

  end

end

describe Book do

  context 'without a library' do
    subject(:book) { FactoryGirl.build :book, library: nil }

    describe 'creation' do
      it "should work fine" do
        book.save
        book.should be_valid
      end
    end

    describe 'destruction' do
      it "should work fine" do
        book.save
        book.destroy
        Book.find_by_id(book.id).should be_nil
      end
    end
  end

end
