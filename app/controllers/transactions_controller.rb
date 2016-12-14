class TransactionsController < ApplicationController
  efore_action :authenticate_user!, except: [:home, :new, :create]
end
