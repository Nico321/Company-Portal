require "spec_helper"
describe 'Sign_in' do

	let!(:superadmin){FactoryGirl.create(:superadmin)}
	let!(:sales){FactoryGirl.create(:sales)}
	let!(:customer){FactoryGirl.create(:customer)}
	let!(:accountend){FactoryGirl.create(:accountend)}
	let!(:technican){FactoryGirl.create(:technican)}

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

	it 'allows to sign in as accountend' do
		login(accountend)
		page.should have_content "Sign out"
	end

	it 'allows to sign in as technican' do
		login(technican)
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
		page.should have_content 'Archiv'
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
	end

	it 'allows to click sales links' do
		login(sales)
		#Bugreport
		page.should have_content 'New bugreport'
		#Request
		page.should have_content 'New request'
		page.should have_content 'Show open requests'
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
		page.should have_content 'Show open assignments'
		#Invoices
		page.should have_content 'Show open invoices'
	end

	it 'allows to click customer links' do
		login(customer)
		#Bugreport
		page.should have_content 'New bugreport'
		#Request
		page.should have_content 'New request'
		page.should have_content 'Show open requests' 
		#Installation
		page.should have_content 'Show open installations'
		#Invoices
		page.should have_content 'Show open invoices'
	end

	it 'allows to click accountend links' do
		login(accountend)
		#Bugreport
		page.should have_content 'New bugreport'
		#Assignments
		page.should have_content 'Show open assignments'
		page.should have_content 'Show unassumed assignments'
		page.should have_content 'Show my assignments'
	end

	it 'allows to click technican links' do
		login(technican)
		#Bugreport
		page.should have_content 'New bugreport'
		page.should have_content 'Show open bugreport'
		#Assignments
		page.should have_content 'Show open assignments'
		page.should have_content 'Show unassumed assignments'
		page.should have_content 'Show my assignments'
	end
end
