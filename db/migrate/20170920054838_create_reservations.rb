class CreateReservations < ActiveRecord::Migration[5.1]
  def up
    create_table :reservations do |t|
    	t.belongs_to :user, index: true, foreign_key: true
    	t.belongs_to :listing, index: true, foreign_key: true
    	t.date :checkin_date
    	t.date :checkout_date
    	t.integer :guest_no
    	t.decimal :total_amount, precision: 5, scale: 2
      t.timestamps
    end
  end

  def down
  	drop_table :reservations
  end
end
