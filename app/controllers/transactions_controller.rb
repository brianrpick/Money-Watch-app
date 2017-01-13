class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def home
    
  end
  def index
    @positive = []
    @negative = []
    @p_total = 0
    @n_total = 0
    @mw_user = current_user
    if !@mw_user.added_plaid
      @user = Plaid::User.exchange_token("#{@mw_user.plaid_token}")
      @mw_user.assign_attributes(plaid_token: @user.access_token, added_plaid: true)
    end
    @user = Plaid::User.load(:connect, "#{@mw_user.plaid_token}")
    @user_t = @user.transactions
    @user_t.each do |trans|
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
    @transaction = Transaction.find_by(params[:plaid_id])
  end

  def update
    @transaction = Transaction.find_by(params[:plaid_id])
    @transaction.assign_attributes(user_id: current_user.id, 
                                   category_id: @transaction.category_id, 
                                   location: @transaction.name, 
                                   amount: @transaction.amount,
                                   date: @transaction.date,
                                   plaid_id: @transaction.id)
    if @transaction.save
      flash[:success] = 'Transaction Successfully Updated'
      redirect_to '/transactions'
    else
      flash[:warning] = @transaction.errors.full_messages.join("<br>").html_safe
      render :index
    end
  end
end
