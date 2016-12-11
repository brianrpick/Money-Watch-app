class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :name
      t.decimal :ammount, precision: 8, scale: 2
      t.datetime :date
      t.string :category
    end
  end
end
