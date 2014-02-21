require 'spec_helper'

describe "Order" do

	let!(:superadmin){FactoryGirl.create(:superadmin)}
	let!(:order){FactoryGirl.create(:order)}
	let!(:assignment){FactoryGirl.create(:assignment)}
	let!(:article){FactoryGirl.create(:article)}
	let!(:pos){FactoryGirl.create(:position)}

	before :each do
		login(superadmin)
		pos.order = order
		pos.offer = order.assignment.offer
		pos.save
	end

	it 'convert an assignment to an order' do
		assignment.agent = superadmin
		assignment.save
		visit assignment_path(assignment)

		expect{click_link "Place order"}.to change{Order.all.count}.by(1)
	end

	it 'update deliverydate' do
		visit order_path(order)

		fill_in "deliverydate", with: DateTime.now.to_date.strftime("%Y-%m-%d")
		expect{click_button "Update Deliverydate"}.to change{order.positions.first.deliverydate}
	end

	it 'mark position as arrived' do
		visit order_path(order)

		expect{click_link "Arrived"}.to change{order.positions.first.arrived}
	end

	it 'add a note to an order' do
		visit order_path(order)
		
		expect{addNote}.to change{Note.all.count}.by(1)
	end
end