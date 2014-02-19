require 'spec_helper'

describe "Invoice" do
	context 'new invoice' do
		it 'convert an installation to an invoice' do
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

			click_link "Arrived"

			visit open_installations_path
			click_link "Assume"
			click_link "Edit"
			expect{click_link "Close installation"}.to change{Invoice.all.count}.by(1)

		end

		it 'you can pay an invoice' do
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

			click_link "Arrived"

			visit open_installations_path
			click_link "Assume"
			click_link "Edit"
			click_link "Close installation"

			page.should have_content "Checkout"
		end

		it 'add a note to an invoice' do
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

			click_link "Arrived"

			visit open_installations_path
			click_link "Assume"
			click_link "Edit"
			click_link "Close installation"

			click_link "Add a note"
			fill_in "note_subject", with: "myTestNote"
			fill_in "note_body", with: "myTestNote"
			
			expect{click_button "Add note"}.to change{Note.all.count}.by(1)
		end

		it 'paypal ipn notification(simulation) test' do
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

			click_link "Arrived"

			visit open_installations_path
			click_link "Assume"
			click_link "Edit"
			click_link "Close installation"

			expect{PaymentNotification.create(:params => "txn", :invoice_id => Invoice.first.id, :status => "Completed")}.to change{Invoice.where("payed IS NOT NULL").count}.by(1)
		end
	end
end