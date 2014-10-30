require './spec_helper'

describe Lend do

	let(:library) { FactoryGirl.build :library }
	let(:book) { FactoryGirl.build :book }
  subject(:lend) { FactoryGirl.build :lend, book: book, library: library }

  describe '#days' do
    it "is 2 when checked out for default amount of time" do
      lend.days.should == 2
    end

    it "is 5 when due date is 5 days after checkout date" do
      lend.checkout  		= Date.today
      lend.due 					= 5.days.from_now.to_date
      lend.days.should 	== 5
    end
  end

  describe '#fees' do
    it "are calculated based on days late and library rate" do
      library.late_fee 	= 10
      lend.checkout   	= 5.days.ago.to_date
			lend.due					= 3.days.ago.to_date
      lend.checkin    	= Date.today

      lend.fees.should 	== 30
    end
  end

end
