require "spec_helper"
require 'capybara/rspec'

describe "Reporting" do 
	before :each do
		login
	end
	
	it "Button Reporting" do		
		click_link "Reporting"
		page.should have_content "Reporting"
	end

	it "Bugreports link" do				
		click_link "Reporting"
		click_link "Bugreports"
		page.should have_content "Bugreports"
	end

	it "Process link" do		
		click_link "Reporting"
		click_link "Process"
		page.should have_content "Process"
	end

	it "Shop link" do		
		click_link "Reporting"
		click_link "Shop"
		page.should have_content "Shop"
	end

	it "User link" do		
		click_link "Reporting"
		click_link "User"
		page.should have_content "User"
	end
end