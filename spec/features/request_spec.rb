require 'spec_helper'

describe "Request" do
	context 'new request' do
		it 'create a new Request' do

			visit  new_user_registration_path
			fill_in "user_email", with: "test@test.de"
			fill_in "user_password", with: "testtest"
			fill_in "user_password_confirmation", with: "testtest"
			click_button "Sign up"

			visit root_path
			click_link "Request"
			click_link "New Request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			
			expect{click_button "Senden"}.to change{Request.count}.by(1)
		end
	end
end