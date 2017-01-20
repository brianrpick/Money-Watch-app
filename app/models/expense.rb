# == Schema Information
#
# Table name: expenses
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  exp_type    :string
#  ammount     :decimal(8, 2)
#  date        :datetime
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Expense < ApplicationRecord
  belongs_to :user

  
  def all_day_expense?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
end
