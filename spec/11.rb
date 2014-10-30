require './spec_helper'

describe Book do
  subject!(:book) { FactoryGirl.create :book }

  describe '#available?' do

    context "without any lendings" do
      it "should be considered available" do
        book.available?.should be_true
      end
    end

    context "currently checked out" do

      let!(:lend) { FactoryGirl.create :current_lend, book: book, library: book.library }

      it "considered unavailable if currently checked out" do
        book.available?.should be_false
      end

		end

		context "is overdue" do

			let!(:overdue) { FactoryGirl.create :unreturned_lend, book: book, library: book.library }

      it "considered unavailable if overdue" do
        book.available?.should be_false
      end

    end

  end

end
