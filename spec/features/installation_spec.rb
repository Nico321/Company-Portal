require 'spec_helper'

describe "Installation" do
	context 'new installation' do
		it 'convert a order to an installation' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"
			visit unassumed_requests_path
			click_link "Assume"
			click_link "Show"
			
			Article.create(:name => "Server", :price => 100, :description => "Test")
			click_link "Create Offer"
			visit unassumed_offers_path
			click_link "Assume"
			click_link "Edit"
			click_link "Add a position"
			click_button "Add position"

			click_link "Publish"
			visit pending_offers_path
			click_link "Show"
			click_link "Accept"

			visit unassumed_assignments_path
			click_link "Assume"
			click_link "Show"
			
			click_link "Place order"
			click_link "Show open orders"
			click_link "Show"

			expect{click_link "Arrived"}.to change{Installation.all.count}.by(1)

		end

		it 'you can assume an installation' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"
			visit unassumed_requests_path
			click_link "Assume"
			click_link "Show"
			
			Article.create(:name => "Server", :price => 100, :description => "Test")
			click_link "Create Offer"
			visit unassumed_offers_path
			click_link "Assume"
			click_link "Edit"
			click_link "Add a position"
			click_button "Add position"

			click_link "Publish"
			visit pending_offers_path
			click_link "Show"
			click_link "Accept"

			visit unassumed_assignments_path
			click_link "Assume"
			click_link "Show"
			
			click_link "Place order"
			click_link "Show open orders"
			click_link "Show"

			click_link "Arrived"

			visit open_installations_path
			expect{click_link "Assume"}.to change{Installation.where("AGENT_ID IS NULL").count}.by(-1)
		end

		it 'add a note to an installation' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"
			visit unassumed_requests_path
			click_link "Assume"
			click_link "Show"
			
			Article.create(:name => "Server", :price => 100, :description => "Test")
			click_link "Create Offer"
			visit unassumed_offers_path
			click_link "Assume"
			click_link "Edit"
			click_link "Add a position"
			click_button "Add position"

			click_link "Publish"
			visit pending_offers_path
			click_link "Show"
			click_link "Accept"

			visit unassumed_assignments_path
			click_link "Assume"
			click_link "Show"
			
			click_link "Place order"
			click_link "Show open orders"
			click_link "Show"

			click_link "Arrived"

			visit open_installations_path
			click_link "Assume"

			click_link "Edit"
			click_link "Add a note"
			fill_in "note_subject", with: "myTestNote"
			fill_in "note_body", with: "myTestNote"
			
			expect{click_button "Add note"}.to change{Note.all.count}.by(1)
		end

		it 'release a installation' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"
			visit unassumed_requests_path
			click_link "Assume"
			click_link "Show"
			
			Article.create(:name => "Server", :price => 100, :description => "Test")
			click_link "Create Offer"
			visit unassumed_offers_path
			click_link "Assume"
			click_link "Edit"
			click_link "Add a position"
			click_button "Add position"

			click_link "Publish"
			visit pending_offers_path
			click_link "Show"
			click_link "Accept"

			visit unassumed_assignments_path
			click_link "Assume"
			click_link "Show"
			
			click_link "Place order"
			click_link "Show open orders"
			click_link "Show"

			click_link "Arrived"

			visit open_installations_path
			click_link "Assume"
			expect{click_link "Release"}.to change{Installation.where("AGENT_ID IS NULL").count}.by(1)
		end
	end
end