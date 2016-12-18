class DateTimetoInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :expenses, :date, :datetime
    add_column :expenses, :date, :integer
  end
end
    