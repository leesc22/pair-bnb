class AddVerifiedToListings < ActiveRecord::Migration[5.1]
  def up
    add_column :listings, :verified, :boolean, default: false
    Listing.update_all(verified: false)
  end

  def down
  	remove_column :listings, :verified
  end
end
