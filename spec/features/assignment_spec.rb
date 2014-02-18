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

		it 'you can assume an assignment' do
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
			expect{click_link "Assume"}.to change{Assignment.where("agent_id IS NOT NULL").count}.by(1)
		end

		it 'add a note to an assignment' do
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
			click_link "Show"

			click_link "Add a note"
			fill_in "note_subject", with: "myTestAssignmentNote"
			fill_in "note_body", with: "myTestAssignmentNote"
			click_button "Add note"
			page.should have_content "myTestAssignmentNote"
		end
	end
end