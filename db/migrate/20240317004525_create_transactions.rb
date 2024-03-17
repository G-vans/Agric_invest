class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :email
      t.string :number
      t.references :investment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
