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

		it 'can assume a offer' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"

			click_link "Create Offer"
			visit unassumed_offers_path

			expect{click_link "Assume"}.to change{Offer.where("agent_id IS NOT NULL").count}.by(1)
		end

		it 'can add a position to a Offer' do
			login

			Article.create(:name => "Server", :price => 100)

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"

			click_link "Create Offer"
			visit unassumed_offers_path
			click_link "Assume"
			click_link "Edit"
			click_link "Add a position"
			expect{click_button "Add position"}.to change{Position.all.count}.by(1)
		end
	end
end