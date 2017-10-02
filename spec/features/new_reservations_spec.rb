require 'rails_helper'
require 'support/clearance_helpers'

RSpec.feature "NewReservations", type: :feature do
	let(:user1) {User.create(name: "David Lim", email: "david@example.com", password: "123456")}
	let(:listing1) {Listing.create(user_id: user1.id, title: "sea view room", address: "seaside", city: "kuala tng", postcode: "21000", state: "terengganu", country: "Malaysia", price_per_night: 175, room_type: "Private room", smoking_allowed: false, pets_allowed:false, wifi: false, pool:false)}

  scenario "User 'book' new reservation" do
  	sign_in
  	visit listing_path(listing1.id)
  	fill_in('reservation[checkin_date]', :with => Date.today + 1.day)
  	fill_in('reservation[checkout_date]', :with => Date.today + 3.day)
  	fill_in('reservation[guest_no]', :with => 1)
  end
end
