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

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
