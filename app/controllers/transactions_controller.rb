class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @positive = []
    @negative = []
    @p_total = 0
    @n_total = 0
    @user_t = Plaid::User.create(:connect, 'wells', 'plaid_test', 'plaid_good')
    @user_t.initial_transactions.each do |trans|
      if trans.amount > 0
        @positive << trans
      else 
        @negative << trans
      end
    end
  end
  def save_trans
    new_trans = []
    transaction = Plaid::User.create(:connect, 'wells', 'plaid_test', 'plaid_good')
    all = Transactions.all.where(:id @current_user.id)
    all.each do |id_check|
      if id_check.id == 
      end
    transaction.each do |trans|
      @transaction = Expense.create(
        user_id: @current.user_id,
        location: trans.initial_transactions.name,
        amount: trans.initial_transactions.amount,
        date: trans.initial_transactions.date,
        category: trans.initial_transactions.category_id,
        plaid_id: trans.id,
        )
    end
  end 
end
