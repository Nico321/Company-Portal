require 'spec_helper'

describe "Offer" do
	context 'new offer' do
		it 'convert a request to a offer' do

			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"

			click_link "Create Offer"
			page.should have_content "Editing offer"
		end

		it 'add a note to a Offer' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"

			click_link "Create Offer"
			click_link "Add a note"
			fill_in "note_subject", with: "myTestNote"
			fill_in "note_body", with: "myTestNote"
			click_button "Add note"
			page.should have_content "myTestNote"
		end
	end
end