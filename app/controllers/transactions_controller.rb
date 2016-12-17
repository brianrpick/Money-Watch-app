class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user_t = Plaid::User.create(:connect, 'wells', 'plaid_test', 'plaid_good')
  end
  def show
    
  end 
end
