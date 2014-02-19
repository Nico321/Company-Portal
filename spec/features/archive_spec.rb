require "spec_helper"
describe "Archive" do
	context 'new archive entry' do
		it 'create request archive' do

			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"

			click_link "Create Offer"
			visit archive_index_path
			page.should have_content "myTest"
		end
	end
end