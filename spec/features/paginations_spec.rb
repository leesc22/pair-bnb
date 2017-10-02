require 'rails_helper'

RSpec.feature "Paginations", type: :feature do
	before do
		FactoryGirl.create_list(:listing, 50)
	end
	scenario "pagination" do
		visit root_path
		expect(page).to have_css('ul li.active', text: '1')
		expect(page).to_not have_css('ul li.active', text: '2')
		expect(page).to_not have_css('ul li.active', text: 'Last')
		click_link 'Last'
		expect(page).to have_css('ul li.active', text: '5')
		expect(page).to_not have_css('ul li.active', text: '4')
		expect(page).to_not have_css('ul li.active', text: 'First')
	end
end
