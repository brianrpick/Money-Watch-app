class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @positive = []
    @negative = []
    @user_t = Plaid::User.create(:connect, 'wells', 'plaid_test', 'plaid_good')
    @user_t.initial_transactions.each do |trans|
      if trans.amount > 0
        @positive << trans
      else 
        @negative << trans
      end
    end

  end
  def show

  end 
end
