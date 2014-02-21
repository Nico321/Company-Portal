require "spec_helper"
require 'capybara/rspec'

describe "Reporting" do 
	let!(:superadmin){FactoryGirl.create(:superadmin)}
	before :each do
		login(superadmin)
	end
	
	it "Button Reporting" do		
		click_link "Reporting"
		page.should have_content "Reporting"
	end

	it "Bugreports link" do				
		click_link "Reporting"
		click_link "Bugreports"
		page.should have_content "Reporting: Bugreports"
	end

	it "Businessprocess link" do		
		click_link "Reporting"
		click_link "Businessprocess"
		page.should have_content "Reporting: Businessprocess"
	end

	it "Shop link" do		
		click_link "Reporting"
		click_link "Shop"
		page.should have_content "Reporting: Shop"
	end

	it "User link" do		
		click_link "Reporting"
		click_link "User"
		page.should have_content "Reporting: User"
	end
end