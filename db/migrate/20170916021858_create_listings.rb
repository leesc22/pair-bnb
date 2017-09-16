class CreateListings < ActiveRecord::Migration[5.1]
  def up
    create_table :listings do |t|
    	t.belongs_to :user, index: true, foreign_key: true
    	t.string :title
    	t.text :description
    	t.string :address
    	t.string :city
    	t.string :postcode
    	t.string :state
    	t.string :country
    	t.string :room_type
    	t.string :bedroom_count
    	t.string :bathroom_count
    	t.decimal :price_per_night, precision: 5, scale: 2
    	t.boolean :smoking_allowed
    	t.boolean :pets_allowed
    	t.boolean :wifi
    	t.boolean :pool
      t.timestamps
    end
  end

  def down
  	drop_table :listings
  end
end
