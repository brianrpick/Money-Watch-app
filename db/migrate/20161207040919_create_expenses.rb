class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.string :name
      t.decimal :ammount, precision: 8, scale: 2
      t.datetime :date
      t.string :description
      t.timestamps
    end
  end
end
