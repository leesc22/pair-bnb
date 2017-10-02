FactoryGirl.define do
  factory :listing do
  	user
  	title "sea view room"
  	address "seaside"
  	city "kuala tng"
  	postcode "21000"
  	state "terengganu"
  	country "Malaysia"
  	price_per_night 175
  	room_type "Private room"
  	smoking_allowed false
  	pets_allowed false
  	wifi false
  	pool false
  end
end