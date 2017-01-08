class UsersController < ApplicationController
  def settings
    @user = current_user
  end

  def new
    render layout: false
  end


  def create
    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Successfully created account!'
      redirect_to '/settings'
    else
      flash[:warning] = @user.errors.full_messages.join("<br>").html_safe
      render :new
    end
  end
  def update
    @user = User.find(params[:id])
    @user.assign_attributes(
      first_name: params[:first_name], 
      last_name: params[:last_name], 
      savings_goal: params[:savings_goal], 
      expense_budget: params[:expense_budget]
      )
    if @user.save
      flash[:success] = 'Your info has been updated!'
      redirect_to '/transactions'
    else
      flash[:warning] = @user.errors.full_messages.join("<br>").html_safe
      render :settings
    end
  end

end
