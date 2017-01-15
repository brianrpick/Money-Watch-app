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

end











