class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.decimal :savings_goal, precision: 8, scale: 2
      t.decimal :expense_budget, precision: 8, scale: 2 

      t.timestamps
    end
  end
end
