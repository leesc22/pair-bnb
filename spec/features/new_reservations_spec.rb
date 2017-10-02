require 'rails_helper'
require 'support/clearance_helpers'

RSpec.feature "NewReservations", type: :feature do
	let(:user) {FactoryGirl.create(:user)}
	let(:listing) {FactoryGirl.create(:listing)}
	let(:reservation) {FactoryGirl.create(:reservation)}

  scenario "User 'book' new reservation & make payment" do
  	sign_in
  	visit listing_path(listing)
  	fill_in('reservation[checkin_date]', :with => Date.today + 1.day)
  	fill_in('reservation[checkout_date]', :with => Date.today + 3.day)
  	fill_in('reservation[guest_no]', :with => 1)
  	click_button 'Book'
  	expect(page.current_path).to eq reservation_path(listing.reservations.last)
  	click_link 'Make Payment'
  	expect(page.current_url).to eq "http://www.example.com/braintree/new?reservation_id=#{listing.reservations.last.id}"
		# fill_in('credit-card-number', :with => '4111 1111 1111 1111')
		# fill_in('expiration', :with => '10/2019')
		# fill_in('cvv', :with => '123')  	
  end
end
