require "spec_helper"
describe 'Sign_in' do

	let!(:superadmin){FactoryGirl.create(:superadmin)}
	let!(:sales){FactoryGirl.create(:sales)}
	let!(:customer){FactoryGirl.create(:customer)}
	let!(:accountant){FactoryGirl.create(:accountant)}
	let!(:technician){FactoryGirl.create(:technician)}

	before(:each) do
	  visit root_path
	end
	 

	it 'allows to sign in as admin' do
		login(superadmin)
		page.should have_content "Sign out"
	end

	it 'allows to sign in as sales' do
		login(sales)
		page.should have_content "Sign out"
	end

	it 'allows to sign in as customer' do
		login(customer)
		page.should have_content "Sign out"
	end

	it 'allows to sign in as accountant' do
		login(accountant)
		page.should have_content "Sign out"
	end

	it 'allows to sign in as technician' do
		login(technician)
		page.should have_content "Sign out"
	end

	it 'allows to click admin links' do
		login(superadmin)
		#Reporting
		page.should have_content 'Reporting'
		#Bugreport
		page.should have_content 'New bugreport'
		page.should have_content 'Show open bugreport' 
		page.should have_content 'Show unassumed bugreports'
		page.should have_content 'Show my bugreport'
		page.should have_content 'Archive'
		#Request
		page.should have_content 'New request'
		page.should have_content 'Show open requests' 
		page.should have_content 'Show unassumed requests'
		page.should have_content 'Show my request'
		#Offer
		page.should have_content 'Pending offers'
		page.should have_content 'Show open offers'
		page.should have_content 'Show unassumed offers'
		page.should have_content 'Show my offers'
		#Assignment
		page.should have_content 'Show open assignments'
		page.should have_content 'Show unassumed assignments'
		page.should have_content 'Show my assignments'
		#Order
		page.should have_content 'Show open orders'
		#Installation
		page.should have_content 'Show open installations'
		page.should have_content 'Show unassumed installations'
		page.should have_content 'Show my installations'
		#Invoices
		page.should have_content 'Show open invoices'
		#Articles
		page.should have_content 'Show Article'
		page.should have_content 'New Article'
	end

	it 'allows to click sales links' do
		login(sales)
		#Bugreport
		page.should have_content 'New bugreport'
		#Request
		page.should have_content 'New request'
		page.should have_content 'Show open requests'
		page.should have_content 'Show unassumed requests'
		page.should have_content 'Show my requests'
		#Offer
		page.should have_content 'Pending offers'
		page.should have_content 'Show open offers'
		page.should have_content 'Show unassumed offers'
		page.should have_content 'Show my offers'
		#Assignment
		page.should have_content 'Show open assignments'
		page.should have_content 'Show unassumed assignments'
		page.should have_content 'Show my assignments'
		#Order
		page.should have_content 'Show open orders'
		#Installation
		page.should have_content 'Show open installations'
		#Invoices
		page.should have_content 'Show open invoices'
		page.should have_content 'Archive'
	end

	it 'allows to click customer links' do
		login(customer)
		#Bugreport
		page.should have_content 'New bugreport'
		#Request
		page.should have_content 'New request'
		page.should have_content 'Overview'
	end

	it 'allows to click accountant links' do
		login(accountant)
		#Bugreport
		page.should have_content 'New bugreport'
		#Assignments
		page.should have_content 'Show open invoices'
		page.should have_content 'Archive'
	end

	it 'allows to click technician links' do
		login(technician)
		#Bugreport
		page.should have_content 'New bugreport'
		page.should have_content 'Show open bugreport'
		#Assignments
		page.should have_content 'Show open installations'
		page.should have_content 'Show unassumed installations'
		page.should have_content 'Show my installations'
	end
end
