class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @positive = []
    @negative = []
    @p_total = 0
    @n_total = 0
    @user_t = Plaid::User.create(:connect, 'wells', 'plaid_test', 'plaid_good')
    @user_t.initial_transactions.each do |trans|
      save_t = Transaction.find_or_create_by(plaid_id: trans.id)
      if !save_t.amount 
        save_t.amount = trans.amount
        save_t.category_id = trans.category_id
        save_t.date = trans.date
        save_t.plaid_id = trans.id
        save_t.user_id = @current_user.id
        save_t.location = trans.name
        if trans.amount > 0
          @positive << trans
        else 
          @negative << trans
        end
      else
        if trans.amount > 0
          @positive << trans
        else 
          @negative << trans
        end
      end
    end
  end


  def edit
    @transaction = transaction.find(params[:id])
  end

  def update
    @transaction = transaction.find(params[:id])
    @transaction.assign_attributes(
      exp_type: params[:exp_type],
      amount: params[:amount],
      date: params[:date],
      description: params[:description]
      )
    if @transaction.save
      flash[:success] = 'Expense Successfully Updated'
      redirect_to '/transactions'
    else
      flash[:warning] = @transaction.errors.full_messages.join("<br>").html_safe
      render :new
    end
  end
end
