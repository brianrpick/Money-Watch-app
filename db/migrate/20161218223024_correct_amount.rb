class CorrectAmount < ActiveRecord::Migration[5.0]
  def change
    rename_column :expenses, :ammount, :amount
  end
end
