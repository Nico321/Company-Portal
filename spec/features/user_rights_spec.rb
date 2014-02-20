require "spec_helper"

describe 'Sign_in' do
  before(:each) do
  visit root_path
 end
 
 



 it 'allows to click admin links' do
  
  
  login_superadmin
  #Reporting
  click_link 'Reporting'
  #Bugreport
  click_link 'New bugreport'
  click_link 'Show open bugreport' 
  click_link 'Show unassumed bugreports'
  click_link 'Show my bugreport'
  click_link 'Archiv'
  #Request
  click_link 'New request'
  click_link 'Show open requests' 
  click_link 'Show unassumed requests'
  click_link 'Show my request'
  #Offer
   click_link 'Pending offers'
  click_link 'Show open offers'
  click_link 'Show unassumed offers'
  click_link 'Show my offers'
  #Assignment
  click_link 'Show open assignments'
  click_link 'Show unassumed assignments'
  click_link 'Show my assignments'
  #Order
  click_link 'Show open orders'
  #Installation
  click_link 'Show open installations'
  click_link 'Show unassumed installations'
  click_link 'Show my installations'
  #Invoices
  click_link 'Show open invoices'
 end

 it 'allows to click sales links' do
  login_sales
  #Bugreport
  click_link 'New bugreport'
  click_link 'Show open bugreport'
  #Request
  click_link 'New request'
  click_link 'Show open requests'
  #Offer
  click_link 'Pending offers'
  click_link 'Show open offers'
  click_link 'Show unassumed offers'
  click_link 'Show my offers'
  #Assignment
  click_link 'Show open assignments'
  click_link 'Show unassumed assignments'
  click_link 'Show my assignments'
  #Order
  click_link 'Show open orders'
  #Installation
  click_link 'Show open assignments'
  #Invoices
  click_link 'Show open invoices'


 end

 it 'allows to click customer links' do
 login_customer
  #Bugreport
  click_link 'New bugreport'
  click_link 'Show open bugreport'
  #Request
  click_link 'New request'
  click_link 'Show open requests' 
  #Installation
  click_link 'Show open installations'
  #Invoices
  click_link 'Show open invoices'

 end
 
 it 'allows to click accountend links' do
  login_accountend
  #Bugreport
  click_link 'New bugreport'
  click_link 'Show open bugreport'
  #Assignments
  click_link 'Show open assignments'
  click_link 'Show unassumed assignments'
  click_link 'Show my assignments'

 end

 it 'allows to click technican links' do
  login_technican
  #Bugreport
  click_link 'New bugreport'
  click_link 'Show open bugreport'
  #Assignments
  click_link 'Show open assignments'
  click_link 'Show unassumed assignments'
  click_link 'Show my assignments'
 end

end
