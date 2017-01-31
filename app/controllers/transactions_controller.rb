class TransactionsController < ApplicationController
  before_action :authenticate_user!

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
    @user_t = current_user.transactions.where(date: Time.now - 1.month..Time.now)
  end


  def edit
    @transaction = Transaction.find_by(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    @transaction.assign_attributes(user_id: current_user.id, 
                                   category_id: params[:category_id], 
                                   location: @transaction.location, 
                                   amount: params[:amount],
                                   date: @transaction.date,
                                   plaid_id: @transaction.plaid_id)
    if @transaction.save
      flash[:success] = 'Transaction Successfully Updated'
      if current_user.grab_other.empty?
        redirect_to '/home'
      else
        redirect_to '/other'    
      end
    else
      flash[:warning] = @transaction.errors.full_messages.join("<br>").html_safe
      render :index
    end
  end

  def home
    gon.categories = @cate_totals
    @totals = []
    total = 0
    @totals.each do |num|
      total += num
    end
    avg = total/12
    
    gon.avg = avg
    gon.total = @totals
    jan = 0
    feb = 0
    mar = 0
    apr = 0
    may = 0
    jun = 0
    jul = 0
    aug = 0
    sep = 0
    oct = 0
    nov = 0
    dec = 0

    @user = User.find(current_user.id)
    transactions = @user.transactions.where(date: Date.new(2016)..Date.new(2017))
    transactions.each do |trans|
      if trans.amount > 0
        if trans.date.month == 1
          jan += trans.amount
        elsif trans.date.month == 2
          feb += trans.amount
        elsif trans.date.month == 3
          mar += trans.amount
        elsif trans.date.month == 4
          apr += trans.amount
        elsif trans.date.month == 5
          may += trans.amount
        elsif trans.date.month == 6
          jun += trans.amount
        elsif trans.date.month == 7
          jul += trans.amount
        elsif trans.date.month == 8
          aug += trans.amount
        elsif trans.date.month == 9
          sep += trans.amount
        elsif trans.date.month == 10
          oct += trans.amount
        elsif trans.date.month == 11
          nov += trans.amount
        elsif trans.date.month == 12
          dec += trans.amount
        end
      end
    end
    @totals << jan
    @totals << feb
    @totals << mar
    @totals << apr
    @totals << may
    @totals << jun
    @totals << jul
    @totals << aug
    @totals << sep
    @totals << oct
    @totals << nov
    @totals << dec

    gon.categories = current_user.categorize_transactions
    gon.category_totals = current_user.total_transactions
    gon.w_totals = current_user.weekly_transactions
  end
  def other
    @transactions = current_user.grab_other 
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



