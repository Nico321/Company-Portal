require 'spec_helper'

describe "Customer Overview" do
	let!(:customer){FactoryGirl.create(:customer)}
	let!(:offer){FactoryGirl.create(:offer, :customer => customer)}
	let!(:request){FactoryGirl.create(:request, :customer => customer)}
	let!(:assignment){FactoryGirl.create(:assignment, :customer => customer)}
	let!(:order){FactoryGirl.create(:order, :customer => customer)}
	let!(:installation){FactoryGirl.create(:installation, :customer => customer)}
	let!(:invoice){FactoryGirl.create(:invoice, :customer => customer)}

	it 'Overview shows processsteps' do
		login(customer)

		click_link "Overview"

		page.should have_content request.subject
		page.should have_content offer.subject
		page.should have_content assignment.subject
		page.should have_content order.subject
		page.should have_content installation.subject
		page.should have_content invoice.subject
	end
end