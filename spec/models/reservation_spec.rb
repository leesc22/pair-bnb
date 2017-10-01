require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:old_checkin_date) { Date.today + 1.day }
	let(:old_checkout_date) { Date.today + 3.day }
  let(:user1) {User.create(name: "David Lim", email: "david@example.com", password: "123456")}
  let(:listing1) {Listing.create(user_id: user1.id, title: "sea view room", address: "seaside", city: "kuala tng", postcode: "21000", state: "terengganu", country: "Malaysia", price_per_night: 175, room_type: "Private room", smoking_allowed: false, pets_allowed:false, wifi: false, pool:false)}
  # let(:reservation1) {Reservation.create(user_id: user1.id, listing_id: listing1.id, checkin_date: old_checkin_date, checkout_date: old_checkout_date, guest_no: 1)}

	context "validations" do
		describe "validates overlapping bookings" do
				
			before do
				Reservation.create(user_id: user1.id, listing_id: listing1.id, checkin_date: old_checkin_date, checkout_date: old_checkout_date, guest_no: 1)
			end

			let(:valid_checkin_date) { Date.today + 4.day }
			let(:valid_checkout_date) { Date.today + 6.day }
			let(:invalid_checkin_date1) { Date.today + 2.day }
			let(:invalid_checkout_date1) { Date.today + 4.day }
			let(:reservation2) {Reservation.create(user_id: user1.id, listing_id: listing1.id, checkin_date: valid_checkin_date, checkout_date: valid_checkout_date, guest_no: 1)}
			let(:reservation3) {Reservation.create(user_id: user1.id, listing_id: listing1.id,checkin_date: invalid_checkin_date1, checkout_date: invalid_checkout_date1, guest_no: 1)}


			it "booking without overlapping dates" do
				expect(reservation2).to be_valid
				# expect(Reservation.find_by(user_id: user1.id, listing_id: listing1.id, checkin_date: valid_checkin_date, checkout_date: valid_checkout_date)).not_to be nil
			end

			it "booking with overlapping dates" do
				expect(reservation3).not_to be_valid
				# Reservation.create()
				# expect(Reservation.find_by()).to be nil
			end
		end
	end

end
