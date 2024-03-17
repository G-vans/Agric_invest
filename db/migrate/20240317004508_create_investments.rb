class CreateInvestments < ActiveRecord::Migration[7.1]
  def change
    create_table :investments do |t|
      t.string :title
      t.text :description
      t.integer :amount
      t.string :image_url

      t.timestamps
    end
  end
end
