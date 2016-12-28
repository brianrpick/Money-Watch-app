class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @positive = []
    @negative = []
    @p_total = 0
    @n_total = 0
    @user_t = Plaid::User.create(:connect, 'wells', 'plaid_test', 'plaid_good')
    @user_t.initial_transactions.each do |trans|
      if !Transaction.find_by(plaid_id: trans.id) 
        Transaction.create(user_id: current_user.id, 
                           category_id: trans.category_id, 
                           location: trans.name, 
                           amount: trans.amount,
                           date: trans.date,
                           plaid_id: trans.id)
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
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
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
