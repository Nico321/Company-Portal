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
		click_link "Bugreports"
		page.should have_content "Bugreports"
	end

	if "Process link" do
		click_link "Process"
		page.should have_content "Process"
	end

	if "Shop link" do
		click_link "Shop"
		page.should have_content "Shop"
	end

	if "User link" do
		click_link "Process"
		page.should have_content "User"
	end
end