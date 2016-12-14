class ExpensesController < ApplicationController
  efore_action :authenticate_user!
  def create
    expense = Expense.create(
        exp_type: params[:exp_type],
        ammount: params[:ammount],
        date: params[:date],
        description: params[:description]
        )
    if expense.save
      flash[:success] = 'Successfully created expense!'
      redirect_to '/'
    else
      flash[:warning] = @expense.errors.full_messages.join("<br>").html_safe
      render :expense
    end
  end
  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    expense = Expense.update_all(
      exp_type: params[:exp_type],
      ammount: params[:ammount],
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
