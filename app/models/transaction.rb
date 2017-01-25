# == Schema Information
#
# Table name: transactions
#
#  id       :integer          not null, primary key
#  user_id  :integer
#  location :string
#  ammount  :decimal(8, 2)
#  date     :datetime
#  category :string
#

class Transaction < ApplicationRecord
  belongs_to :user

  def monthly_spending
    user = current_user
    monthly_trans = @user.transactions.where(date: Time.now - 1.month..Date.today)
    monthly_trans.each do |trans|
    end
  end
  def weekly_spending
    user = current_user
    weekly_trans = @user.transactions.where(date: Time.now - 1.week..Date.today)
    weekly_trans.each do |trans|
    end
  end

  def find_category
    categories = {
      "10" => "Bank Fees",
      "11" => "Cash Advance",
      "12" => "Community",
      "13" => "Food and Drink",
      "14" => "Healthcare",
      "15" => "Interest",
      "16" => "Payment",
      "17" => "Recreation",
      "18" => "Service",
      "19" => "Shops",
      "20" => "Tax",
      "21" => "Transfer",
      "22" => "Travel"
     }
    if category_id
      return categories[category_id.to_s[0..1]]
    else
      return "Other"
    end
  end
end
