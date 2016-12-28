class TransactionAmmountToAmount < ActiveRecord::Migration[5.0]
  def change
    rename_column :transactions, :ammount, :amount
  end
end
