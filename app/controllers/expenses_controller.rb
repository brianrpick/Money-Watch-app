class ExpensesController < ApplicationController
  before_action :authenticate_user!
  def create
    @expense = Expense.create(
        user_id: params[:user_id],
        exp_type: params[:exp_type],
        amount: params[:amount],
        date: params[:date],
        description: params[:description]
        )
    if @expense.save
      flash[:success] = 'Successfully created expense!'
      redirect_to '/expenses'
    else
      flash[:warning] = @expense.errors.full_messages.join("<br>").html_safe
      render :expenses 
    end
  end

  def index
    @expenses = Expense.all.where(user_id: @current_user.id)
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    expense = Expense.update_all(
      exp_type: params[:exp_type],
      amount: params[:amount],
      date: params[:date],
      description: params[:description]
      )
    if expense.save
      flash[:success] = 'Successfully created account!'
      redirect_to '/'
    else
      flash[:warning] = @expense.errors.full_messages.join("<br>").html_safe
      render :new
    end
  end
end
