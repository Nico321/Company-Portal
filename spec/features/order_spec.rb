require 'spec_helper'

describe "Order" do
	context 'new order' do
		it 'convert an assignment to an order' do

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
			click_link "Accept"

			visit unassumed_assignments_path
			click_link "Assume"
			click_link "Show"

			expect{click_link "Place order"}.to change{Order.all.count}.by(1)
		end

		it 'update deliverydate' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"
			
			Article.create(:name => "Server", :price => 100, :description => "Test")
			click_link "Create Offer"
			visit unassumed_offers_path
			click_link "Assume"
			click_link "Edit"
			click_link "Add a position"
			click_button "Add position"			
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

			fill_in "deliverydate", with: DateTime.now.to_date.strftime("%Y-%m-%d"), :match => :first
			click_button "Update Deliverydate", :match => :first
			page.should have_content "Deliverydate successfully updated."
		end

		it 'mark position as arrived' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"
			
			Article.create(:name => "Server", :price => 100, :description => "Test")
			click_link "Create Offer"
			visit unassumed_offers_path
			click_link "Assume"
			click_link "Edit"
			click_link "Add a position"
			click_button "Add position"	
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

			click_link "Arrived", :match => :first
			page.should have_content "Position arrived."
		end

		it 'add a note to an order' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"
			
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

			click_link "Add a note"
			fill_in "note_subject", with: "myTestNote"
			fill_in "note_body", with: "myTestNote"
			
			expect{click_button "Add note"}.to change{Note.all.count}.by(1)
		end
	end
end