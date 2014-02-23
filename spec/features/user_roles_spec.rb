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
end
