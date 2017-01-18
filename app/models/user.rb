# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  savings_goal    :decimal(8, 2)
#  expense_budget  :decimal(8, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password
  has_many :transactions
  has_many :expenses
  
  # validates :email, uniqueness: true
  # validates :first_name, :last_name, presence: { message: "must be given please" }
  def categorize_transactions
    category_totals = {}
    transactions.where(date: Date.new(2016)..Date.new(2017)).each do |trans|
      if category_totals[trans.find_category]
        category_totals[trans.find_category] += 1
      else
        category_totals[trans.find_category] = 1
      end
    end
    return category_totals 
  end
    # validates :first_name, :last_name, presence: { message: "must be given please" }
  def total_transactions
    amount_totals = {}
    transactions.where(date: Time.now - 1.month..Time.now).each do |trans|
      if trans.amount > 0
        if amount_totals[trans.find_category]
          amount_totals[trans.find_category] += trans.amount
        else
          amount_totals[trans.find_category] = trans.amount
        end
      end
    end
    return amount_totals 
  end
  def grab_other
    other_trans = []
    transactions.where(category_id: nil). each do |trans|
      other_trans << trans
    end
    return other_trans
  end
end










