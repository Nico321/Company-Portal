require "spec_helper"
describe "Archive" do
	context 'new archive entry' do
		 let!(:superadmin){FactoryGirl.create(:superadmin)}
		it 'create request archive' do

			login(superadmin)

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			click_button "Senden"
			visit unassumed_requests_path
			click_link "Assume"
			click_link "Show"

			click_link "Create Offer"
			visit archive_index_path
			page.should have_content "myTest"
		end
	end
end