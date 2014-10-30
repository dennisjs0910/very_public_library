require './spec_helper'

### Custom SQL that gets executed in this test.
# This method should return the correct SQL string.
# PLEASE EDIT THE SQL IN THIS METHOD. ONLY EDIT THIS METHOD
def book_with_closest_due_date_sql
  "SELECT books.title FROM books
  INNER JOIN lends
  ON books.id = lends.book_id
  WHERE (lends.due > '#{Date.today}')
  ORDER BY (lends.due)
  LIMIT 1
  ;"
end


# Executes your custom_sql. DO NOT EDIT
def book_with_closest_due_date
  ActiveRecord::Base.connection.exec_query(book_with_closest_due_date_sql).collect &:values
end

describe 'Custom SQL Method: #book_with_closest_due_date' do

  let!(:library) { FactoryGirl.create :library }
  let!(:book1) { FactoryGirl.create :book, library: library, title: 'A' }
  let!(:book2) { FactoryGirl.create :book, library: library, title: 'B' }
  let!(:book3) { FactoryGirl.create :book, library: library, title: 'C' }
  let!(:book4) { FactoryGirl.create :book, library: library, title: 'D' }
  let!(:book5) { FactoryGirl.create :book, library: library, title: 'E' }
  let!(:lend1) { FactoryGirl.create :lend, library: library, book: book1, due: 10.days.from_now.to_date }
  let!(:lend2) { FactoryGirl.create :lend, library: library, book: book2, due: 12.days.from_now.to_date }
  let!(:lend3) { FactoryGirl.create :lend, library: library, book: book3, due: 05.days.from_now.to_date }
  let!(:lend4) { FactoryGirl.create :lend, library: library, book: book4, due: 20.days.from_now.to_date }
  let!(:lend5) { FactoryGirl.create :lend, library: library, book: book5, due: 3.days.ago.to_date, checkout: 5.days.ago.to_date }

  it "returns the name of the one book that has the most upcoming due date" do
    # Needs to not include old book (that have already checked in)
    book_with_closest_due_date.should == [
      ['C']
    ]
  end

end
