class AddedPlaidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :added_plaid, :boolean, default: false
  end
end