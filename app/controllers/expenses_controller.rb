class ExpensesController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  def index
    # if !params[:start]
    #   @expenses = Expense.where(user_id: current_user.id)
    # else
    #   @expenses = Expense.where(user_id: current_user.id, start: params[:start]..params[:end])
    # end
    @expenses = Expense.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
    @expense = Expense.find_by(id: params[:id])
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.save

    respond_to do |format|
      format.html {redirect_to "/"}
      format.js 
    end

  end

  def update
    @expense = Expense.find_by(id: params[:id])
    @expense.update(expense_params)
  end

  def destroy
    @expense = Expense.find_by(id: params[:id])
    @expense.destroy
  end

  private
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.permit(:id, :title, :date_range, :user_id, :amount, :start, :end, :color)
    end 
end
