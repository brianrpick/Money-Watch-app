class AddPlaidTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :plaid_token, :string
  end
end
