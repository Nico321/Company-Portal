require "spec_helper"

describe 'Sign_in' do
  before(:each) do
  visit root_path
 end
 

 it 'allows to sign in as admin' do
  login_superadmin
 end

 it 'allows to sign in as sales' do
  login_sales
 end

 it 'allows to sign in as customer' do
  login_customer
 end
 
 it 'allows to sign in as accountend' do
  login_accountend
 end

 it 'allows to sign in as technican' do
  login_technican
 end

end
