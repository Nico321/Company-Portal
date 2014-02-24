require "spec_helper"
require 'capybara/rspec'

describe "Bugreports"  do 
 let!(:superadmin){FactoryGirl.create(:superadmin)}
 let!(:bugreport){FactoryGirl.create(:bugreport)}
 let!(:bugreport){Bugreport.create(subject: "new Subject", description: "new description", reporter: superadmin, agent: superadmin)}

	before :each do
		login(superadmin)
	end

		it "dropdown menue" do		
			click_link "New bugreport"
			page.should have_content "New bugreport"
		end

		it "create new bugreport" do	
			visit "bugreports/new"
			fill_in "bugreport_subject", with: "Error 500"
			fill_in "bugreport_description", with: "Error"
			#click_button "Create Bugreport"
			expect{click_button "Create Bugreport"}.to change{Bugreport.count}.by(1)
		end

		it "assume bugreport" do
			visit "bugreports/open"
			page.all(:link,"Assume")[0].click
			page.should have_content "My Bugreports"
		end

		it "is able to close" do
			visit assumed_bugreports_path
			click_link "Show"
			expect{click_link "Close"}.to change{Bugreport.where("closed is not null").count}.by(1)
		end

		it "is not possible to close closed Bugreports" do
			visit "bugreports/closed"
			page.all(:link,"Show")[0].click
			page.should_not have_content "Close"
		end
end