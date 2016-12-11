# == Schema Information
#
# Table name: transactions
#
#  id       :integer          not null, primary key
#  user_id  :integer
#  name     :string
#  ammount  :decimal(8, 2)
#  date     :datetime
#  category :string
#

class Transaction < ApplicationRecord
  belongs_to :user
end
