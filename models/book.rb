class Book < ActiveRecord::Base
belongs_to :library
has_many :lends
validates :title, presence: true, length: { maximum: 500}
validates :author, presence: true, length: { minimum: 5, maximum: 100}
validates :pages, numericality: { greater_than_or_equal_to: 4 }
validates :isbn, format: { with: /\A\d\d\d\d\d\d\d\d\d-.\z/, message: "is not a valid ISBN"}




  def available?
    if lends.count > 0
      lends.last.checkin ? true : false
    else
      true
    end
  end



end
