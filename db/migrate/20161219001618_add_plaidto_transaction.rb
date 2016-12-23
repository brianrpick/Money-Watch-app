class AddPlaidtoTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :plaid_id, :string
  end
end
