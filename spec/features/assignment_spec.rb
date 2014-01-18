require 'spec_helper'

describe "Assignment" do
	context 'new assignment' do
		it 'convert a offer to an assignment' do

			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"

			click_link "Create Offer"
			visit unassumed_offers_path
			click_link "Assume"
			click_link "Edit"

			click_link "Publish"
			visit pending_offers_path
			click_link "Show"
			expect{click_link "Accept"}.to change{Assignment.all.count}.by(1)
		end
	end
end