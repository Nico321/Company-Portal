require "spec_helper"
require 'capybara/rspec'
	let!(:superadmin){FactoryGirl.create(:superadmin)}
	let!(:customer){FactoryGirl.create(:customer)}

describe "Bugreports"  do 
	before :each do
		login
		cu = User.last
		Bugreport.create(:subject => "Can't Order", :description => "is not possible", :reporter_id => cu.id)
		Bugreport.create(:subject => "got no invoice", :description => "invoice",:reporter_id => cu.id , :agent_id => cu.id)
		Bugreport.create(:subject => "login failed", :description => "logon",:reporter_id => cu.id , :agent_id => cu.id, :closed => Time.now)
		
	end

		it "dropdown menue" do		
			click_link "New bugreport"
			page.should have_content "New bugreport"
		end

		it "create new bugreport" do	
			visit "bugreports/new"
			fill_in "bugreport_subject", with: "Subject1"
			fill_in "bugreport_description", with: "Description"
			click_button "Create Bugreport"

			visit "bugreports/open"
			page.should have_content "Subject1"
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