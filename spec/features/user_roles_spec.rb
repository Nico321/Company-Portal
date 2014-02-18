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
