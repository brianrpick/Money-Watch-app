class Api::V1::UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
    @user.update_attributes(plaid_token: params[:public_token])
    render json: @user
  end
end
