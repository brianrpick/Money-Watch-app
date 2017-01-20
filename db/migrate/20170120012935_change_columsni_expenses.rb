class ChangeColumsniExpenses < ActiveRecord::Migration[5.0]
  def change
    remove_column :expenses, :exp_type, :string
    remove_column :expenses, :date, :string
    add_column :expenses, :start, :datetime
    add_column :expenses, :end, :datetime
    rename_column :expenses, :description, :title
  end
end
