class SessionsController < ApplicationController
  def new
    render layout: false
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:sucess] = "Logged in Sucessfully"
      redirect_to "/transactions"
    else
      flash[:warning] = "Invalid email or password!"
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:sucess] = "You have sucesfully logged out"
    redirect_to "/"
  end
end

