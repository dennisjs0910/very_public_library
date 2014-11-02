require './spec_helper'

### Custom SQL that gets executed in this test.
# This method should return the correct SQL string.
# PLEASE EDIT THE SQL IN THIS METHOD. ONLY EDIT THIS METHOD
def books_not_sorted_to_libraries_sql
  "SELECT b.title, l.name FROM books b
  LEFT JOIN libraries l
  ON b.library_id = l.id
  ORDER BY b.title;"
end

# Executes your custom_sql. DO NOT EDIT
def books_not_sorted_to_libraries
  ActiveRecord::Base.connection.exec_query(books_not_sorted_to_libraries_sql).collect &:values
end

describe 'Custom SQL Method: #books_not_sorted_to_libraries' do

	let!(:library) { FactoryGirl.create :library, name: 'Library' }

  let!(:a) { FactoryGirl.create :book, library: library, title: 'A' }
  let!(:b) { FactoryGirl.create :book, library: nil, title: 'B' } 
  let!(:c) { FactoryGirl.create :book, library: library, title: 'C' }
  let!(:d) { FactoryGirl.create :book, library: nil, title: 'D' }
  let!(:e) { FactoryGirl.create :book, library: library, title: 'E' }

	it "returns all book titles, and the library name for all books (whether they have been sorted to a library or not)" do
		books_not_sorted_to_libraries.should == [
			['A', 'Library'],
			['B', nil],
			['C', 'Library'],
			['D', nil],
			['E', 'Library']
		]
	end
end
