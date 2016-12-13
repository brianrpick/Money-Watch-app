class SessionsController < ApplicationController
  def new
  end

  def create
    #find user by the id passed by email params
    user = User.find_by(email: params[:email])
    #if user is sucesfully authenticated save id in cookie redirect to '/' route
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:sucess] = "Logged in Sucessfully"
      redirect_to "/"
    else
      #if user does not pass authentication, send flashing waring, reload login page
      flash[:warning] = "Invalid email or password!"
      redirect_to "/login"
    end
  end

  def destroy
  #end user session
    
    session[:user_id] = nil
    flash[:sucess] = "You have sucesfully logged out"
    redirect_to "/"
  end
end

