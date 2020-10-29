class CreateExchanges < ActiveRecord::Migration[6.0]
  def change
    create_table :exchanges do |t|
      t.string :company_name
      t.integer :tax_id
      t.string :tel

      t.timestamps
    end
  end
end
