require 'spec_helper'

describe "Invoice" do
	let!(:superadmin){FactoryGirl.create(:superadmin)}
	let!(:order){FactoryGirl.create(:order)}
	let!(:installation){FactoryGirl.create(:installation)}
	let!(:article){FactoryGirl.create(:article)}
	let!(:pos){FactoryGirl.create(:position)}
	let!(:invoice){FactoryGirl.create(:invoice)}

	before :each do
		login(superadmin)
	end

	it 'convert an installation to an invoice' do
		installation.agent = superadmin
		installation.save
		visit edit_installation_path(installation)
		expect{click_link "Close installation"}.to change{Invoice.all.count}.by(1)

	end

	it 'you can pay an invoice' do
		logout
		login(invoice.customer)
		visit invoice_path(invoice)

		page.should have_content "Checkout"
	end

	it 'add a note to an invoice' do
		visit invoice_path(invoice)
		expect{addNote}.to change{Note.all.count}.by(1)
	end

	it 'paypal ipn notification(simulation) test' do
		expect{PaymentNotification.create(:params => "txn", :invoice_id => invoice.id, :status => "Completed")}.to change{Invoice.where("payed IS NOT NULL").count}.by(1)
	end
end