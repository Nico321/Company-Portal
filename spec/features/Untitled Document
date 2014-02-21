describe 'Sign_in' do
  before(:each) do
  visit root_path
 end
 
 
 it 'allows to sign in as admin' do
  click_link 'Sign in'
  fill_in "user_email", with: 'admin@example.de'
  fill_in "user_password", with: 'testtest'
 end

 it 'allows to sign in as sales' do
  click_link 'Sign in'
  fill_in "user_email", with: 'sales@example.de'
  fill_in "user_password", with: 'testtest'


  #Bugreport
  click_link 'New bugreport'
  click_link 'Show open bugreport'
  click_link 'Show unassumed bugreports'
   
  expect(false)
  click_link 'Show my bugreports'
  expect(false)
  click_link 'Archiv'
  expect(false)

  #Request
  click_link 'New request'
  expect( throw StandardError).to have_content 'click_link "New request"'
  click_link 'Show open requests'
  click_link 'Show unassumed requests'
  click_link 'Show my requests'



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

 end

 it 'allows to sign in as customer' do
  click_link 'Sign in'
  fill_in "user_email", with: 'customer@example.de'
  fill_in "user_password", with: 'testtest'
 end
 
 it 'allows to sign in as accountend' do
  click_link 'Sign in'
  fill_in "user_email", with: 'accountend@example.de'
  fill_in "user_password", with: 'testtest'
 end

 it 'allows to sign in as technican' do
  click_link 'Sign in'
  fill_in "user_email", with: 'technican@example.de'
  fill_in "user_password", with: 'testtest'
 end

end
