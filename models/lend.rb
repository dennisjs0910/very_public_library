class Lend < ActiveRecord::Base
belongs_to :library
belongs_to :book 
validate :valid_due_date
validate :valid_check_out

before_save :library_revenue
before_create :valid_extensions

  def valid_due_date
    if self.due
      if self.checkout < self.due
        true
      else
        self.errors.add(:due, "due date must be after checkout")
        false
      end
    end
  end

  def valid_check_out
    if self.checkin
      if self.checkout < self.checkin
        true
      else
        self.errors.add(:checkin, "checkin date must be after checkout")
        false
      end
    end
  end


 def days
    self.due - self.checkout
  end



  def overdue
    if self.checkin && self.checkin > self.due 
      true
    else
      false
    end
  end

 

  def fees  
    if overdue
      (self.checkin - self.due) * self.library.late_fee
    else
      nil
    end 

  end

 # protected

  def library_revenue
    if checkin
      library.revenue = fees
      library.save
    end
  end

  def valid_extensions
    if checkin
      if due > 2.days.from_now.to_date
        self.extended = true
      else
        self.extended = false
      end
    end
  end



end
