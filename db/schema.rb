# DO NOT MODIFY

ActiveRecord::Schema.define do
  create_table :libraries, force: true do |t|
    t.string     :name
    t.integer    :late_fee
    t.integer    :capacity
    t.integer    :revenue, default: 0
    t.timestamps
  end

  create_table :books, force: true do |t|
    t.references 	:library
    t.string     	:title
		t.string		 	:author
		t.string		 	:abstract
    t.integer    	:pages
		t.string		 	:isbn
    t.timestamps
  end

	create_table :lends, force: true do |t|
		t.references	:library
		t.references	:book
		t.date				:due
    t.date       	:checkin
    t.date       	:checkout
		t.boolean			:extended, default: false
		t.timestamps
	end
end
