class ExpensesController < ApplicationController
  before_action :authenticate_user!
  def index
    @expenses = Expense.where(start: params[:start]..params[:end])
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.save
  end

  def update
    @expense.update(expense_params)
  end

  def destroy
    @expense.destroy
  end

  private
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:title, :date_range, :amount, :start, :end, :color)
    end 
end
