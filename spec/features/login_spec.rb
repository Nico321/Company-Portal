require 'spec_helper'

describe 'Sign_up' do
  before(:each) do

  visit root_path
 end

 it 'allows to sign up as customer' do
  visit new_user_registration_path
  within page.find("#new_user") do
    fill_in "user_email", with: 'kunde@example.de'
    fill_in "user_password", with: '12345678'
    fill_in "user_password_confirmation", with: '12345678'
  end
  expect { page.find("#new_user .btn-info").click()}.to change { User.all.count }.by(1)

  user = User.all.last
  if user.has_role (:customer)
   true
  else
   lambda {raise "not a customer"}.should raise_error
  end

 end

 context 'existing user' do
  let!(:customer) {FactoryGirl.create :customer}
  
  before(:each) do
   login(customer)
  end
 
  it 'allows to sign out' do
   click_link 'Sign out'
   page.should have_content "Signed out successfully."
  end

  it 'allows to edit your profile' do   
   click_link 'Edit profile'
     within page.find("#edit_user") do
       fill_in "user_password", with: "testtest"
       fill_in "user_password_confirmation", with: "testtest"
       fill_in "user_current_password", with: "testtest"
       fill_in "user_firstname", with: "Johnny"
       fill_in "user_lastname", with: "Kontrolletti"
       click_button "Update"

   end
   page.should have_content "You updated your account successfully."
  end
 end

end
