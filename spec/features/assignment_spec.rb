require 'spec_helper'

describe "Assignment" do

	let!(:superadmin){FactoryGirl.create(:superadmin)}
	let!(:offer){FactoryGirl.create(:offer)}
	let!(:assignment){FactoryGirl.create(:assignment)}

	before :each do
		login(superadmin)
	end

	it 'convert a offer to an assignment' do
		offer.publication = DateTime.now
		offer.customer = superadmin
		offer.save
		visit offer_path(offer)

		expect{click_link "Accept"}.to change{Assignment.all.count}.by(1)
	end

	it 'you can assume an assignment' do
		visit unassumed_assignments_path
		expect{click_link "Assume"}.to change{Assignment.where("agent_id IS NOT NULL").count}.by(1)
	end

	it 'you can release an assignment' do
		assignment.agent = superadmin
		assignment.save
		visit assumed_assignments_path
		expect{click_link "Release"}.to change{Assignment.where("agent_id IS NOT NULL").count}.by(-1)
	end

	it 'add a note to an assignment' do
		visit assignment_path(assignment)
		addNote
		page.should have_content "myTestNote"
	end
end