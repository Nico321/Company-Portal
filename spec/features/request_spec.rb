require 'spec_helper'

describe "Request" do			
	let!(:superadmin){FactoryGirl.create(:superadmin)}
	let!(:request){FactoryGirl.create(:request)}

	before :each do
		login(superadmin)
	end
		
	it 'create a new Request' do
		click_link "New request"
		fill_in "request_subject", with: "myTest"
		fill_in "request_body", with: "Test"
		
		expect{click_button "Senden"}.to change{Request.count}.by(1)
	end

	it 'show unassumed requests' do

		click_link "Show unassumed requests"
		page.should have_content request.subject
	end

	it 'assume request' do

		click_link "Show unassumed requests"
		expect{click_link "Assume"}.to change{Request.where("agent_id IS NULL").count}.by(-1)
	end

	it 'release request' do

		visit root_path
		click_link "Show unassumed requests"
		click_link "Assume"

		expect{click_link "Release"}.to change{Request.where("agent_id IS NULL").count}.by(1)
	end

	it 'add notes to request' do

		visit request_path(request)
		addNote

		page.should have_content "TestNote"
	end
end