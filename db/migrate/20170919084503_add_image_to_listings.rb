class AddImageToListings < ActiveRecord::Migration[5.1]
  def up
    add_column :listings, :images, :json
  end

  def down
  	remove_column :listings, :images
  end
end
