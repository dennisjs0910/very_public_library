require './spec_helper'

describe Library do

  subject(:library) { FactoryGirl.build :library }
	let!(:another_library) { FactoryGirl.create :library }

  describe '#name' do
    it "is required" do
      library.name = nil
      library.should_not be_valid
      expect(library.errors[:name]).to include "can't be blank"
    end
    it "must be longer than 3 letters" do
      library.name = 'abc' 
      library.should_not be_valid
      library.errors[:name].should == ["is too short (minimum is 4 characters)"]
    end
    it "must be unique" do
      library.name = another_library.name

      library.should_not be_valid
      library.errors[:name].should == ['has already been taken']
    end
  end

  describe '#late_fee' do
    it "is required (can't be nil; must be a number)" do
      library.late_fee = nil
      library.should_not be_valid
      expect(library.errors[:late_fee]).to include "is not a number"
    end

   it "must be a number (integer) only" do
      library.late_fee = 'abc'
      library.should_not be_valid
      library.errors[:late_fee].should == ["is not a number"]
    end
  end

  describe '#capacity' do
    it "is required to be number" do
      library.capacity = nil
      library.should_not be_valid
      expect(library.errors[:capacity]).to include "is not a number"
    end

		it "must be at least 1000" do
			library.capacity = 999
			library.should_not be_valid
			library.errors[:capacity].should == ["must be greater than or equal to 1000"]
		end

    it "must be a number (integer) only" do
      library.capacity = 'abc'
      library.should_not be_valid
      library.errors[:capacity].should == ["is not a number"]
    end
  end

end

