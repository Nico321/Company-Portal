require 'spec_helper'

describe "Installation" do
	let!(:superadmin){FactoryGirl.create(:superadmin)}
	let!(:order){FactoryGirl.create(:order)}
	let!(:installation){FactoryGirl.create(:installation)}
	let!(:article){FactoryGirl.create(:article)}
	let!(:pos){FactoryGirl.create(:position)}

	before :each do
		login(superadmin)
	end

	it 'convert a order to an installation' do
		pos.order = order
		pos.offer = order.assignment.offer
		pos.save
		visit order_path(order)

		expect{click_link "Arrived"}.to change{Installation.all.count}.by(1)

	end

	it 'you can assume an installation' do
		visit open_installations_path
		expect{click_link "Assume"}.to change{Installation.where("AGENT_ID IS NULL").count}.by(-1)
	end

	it 'add a note to an installation' do
		visit installation_path(installation)
		
		expect{addNote}.to change{Note.all.count}.by(1)
	end

	it 'release a installation' do
		installation.agent = superadmin
		installation.save
		visit assumed_installations_path

		expect{click_link "Release"}.to change{Installation.where("AGENT_ID IS NULL").count}.by(1)
	end
end