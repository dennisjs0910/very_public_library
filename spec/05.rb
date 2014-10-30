require './spec_helper'

describe Lend do

  subject(:lend) 	{ Lend.new }
	let(:library)		{ Library.new }
	let(:book)			{ Book.new }

	describe "associations" do
		it "should be able to get its library" do
			expect { lend.library }.not_to raise_error
		end

		it "should be able to set its library" do
			expect { lend.library = library }.not_to raise_error
		end

		it "should be able to get its book" do
			expect { lend.book }.not_to raise_error
		end

		it "should be able to set its book" do
			expect { lend.book = book }.not_to raise_error
		end
	end

	describe "validations" do
		it "disallow for the due date to be before the checkout date" do
			lend.due = 1.day.ago.to_date
			lend.checkout = Date.today
			lend.should_not be_valid
			lend.errors[:due].should == ["due date must be after checkout"]
		end

		it "disallow the checkin date to be before the checkout date" do
			lend.checkin = 1.day.ago.to_date
			lend.checkout	= Date.today
			lend.should_not be_valid
			lend.errors[:checkin].should == ["checkin date must be after checkout"]
		end

	end

end
