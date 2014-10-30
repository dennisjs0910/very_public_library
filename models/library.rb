class Library < ActiveRecord::Base
has_many :books, dependent: :destroy  
has_many :lends
validates :name, presence: true, length: { minimum: 4 }, uniqueness: true
validates :late_fee, numericality: { greater_than: 0 }
validates :capacity, numericality: { greater_than_or_equal_to: 1000 }



end
