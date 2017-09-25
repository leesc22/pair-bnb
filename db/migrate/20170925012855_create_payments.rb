class CreatePayments < ActiveRecord::Migration[5.1]
  def up
    create_table :payments do |t|
    	t.belongs_to :reservation, index: true, foreign_key: true
    	t.decimal :amount, precision: 5, scale: 2
      t.timestamps
    end
  end

  def down
  	drop_table :payments
  end
end
