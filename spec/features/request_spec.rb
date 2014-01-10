require 'spec_helper'

describe "Request" do
	context 'new request' do
		it 'create a new Request' do

			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "myTest"
			fill_in "request_body", with: "Test"
			
			expect{click_button "Senden"}.to change{Request.count}.by(1)
		end
	end

	let!(:request){Request.new :subject => "myTest", :body => "Test", :urgency => "1"}
	let!(:c) {User.create :email => "test@test.de", :encrypted_password => "test"}

	context 'show requests' do
		it 'show unassumed requests' do
			login

			request.customer = User.first
			request.save

			visit root_path
			click_link "Show unassumed requests"
			page.should have_content "myTest"
		end

		it 'assume request' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "assumeRequest"
			fill_in "request_body", with: "Test"
			click_button "Senden"

			visit root_path
			click_link "Show unassumed requests"
			click_link "Assume"

			page.should have_content "assumeRequest"
		end

		it 'release request' do
			login

			visit root_path
			click_link "New request"
			fill_in "request_subject", with: "releaseRequest"
			fill_in "request_body", with: "Test"
			click_button "Senden"

			visit root_path
			click_link "Show unassumed requests"
			click_link "Assume"

			click_link "Release"

			page.should_not have_content "releaseRequest"
		end
	end
end