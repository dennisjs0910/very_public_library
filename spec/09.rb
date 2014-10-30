require './spec_helper'

### Custom SQL that gets executed in this test.
# This method should return the correct SQL string.
# PLEASE EDIT THE SQL IN THIS METHOD. ONLY EDIT THIS METHOD
def overdue_books_in_last_30_days_sql
  "SELECT b.title, b.author, b.isbn FROM books b
  INNER JOIN libraries l
  ON b.library_id = l.id
  INNER JOIN lends lend
  ON b.id = lend.book_id
  WHERE (lend.due < '#{Date.today}' AND lend.due > '#{30.days.ago.to_date}')
  ORDER BY b.title
  ;"
end

# Executes your custom_sql. DO NOT EDIT
def overdue_books_in_last_30_days
  ActiveRecord::Base.connection.exec_query(overdue_books_in_last_30_days_sql).collect &:values
end

describe 'Custom SQL Method: #overdue_books_in_last_30_days' do

	let!(:library) { FactoryGirl.create :library }

  let!(:a) { FactoryGirl.create :book, library: library, title: 'A' }
  let!(:b) { FactoryGirl.create :book, library: library, title: 'B' } 
  let!(:c) { FactoryGirl.create :book, library: library, title: 'C' }
  let!(:d) { FactoryGirl.create :book, library: library, title: 'D' }
  let!(:e) { FactoryGirl.create :book, library: library, title: 'E' }
  let!(:f) { FactoryGirl.create :book, library: library, title: 'F' }
  let!(:g) { FactoryGirl.create :book, library: library, title: 'G' }

	let!(:lend1) { FactoryGirl.create :overdue_lend, library: library, book: a }
	let!(:lend2) { FactoryGirl.create :overdue_lend, library: library, book: b }
	let!(:lend3) { FactoryGirl.create :lend, library: library, book: c }
	let!(:lend4) { FactoryGirl.create :overdue_lend, library: library, book: d }
	let!(:lend5) { FactoryGirl.create :overdue_lend, library: library, book: e }
	let!(:lend6) { FactoryGirl.create :lend, library: library, book: f }
	let!(:lend7) { FactoryGirl.create :lend, library: library, book: g }

  it "returns all overdue book's titles, authors, and isbn numbers for books overdue in the last 30 days" do
    # Expect all 5 books (single column rows)
    overdue_books_in_last_30_days.should == [
      ['A', a.author, a.isbn],
      ['B', b.author, b.isbn],
      ['D', d.author, d.isbn],
      ['E', e.author, e.isbn]
    ]
  end

end
