class AddColorToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :color, :string
  end
end
