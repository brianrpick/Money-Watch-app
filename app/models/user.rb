# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  savings_goal    :decimal(8, 2)
#  expense_budget  :decimal(8, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_many :transactions
  has_many :expenses
end
