require 'spec_helper'

describe 'Sign_up' do
  before(:each) do

  visit root_path
 end

 it 'allows to sign up as customer' do
  click_link 'Sign up'
  within page.find("#new_user") do
    fill_in "user_email", with: 'kunde@example.de'
    fill_in "user_password", with: '12345678'
    fill_in "user_password_confirmation", with: '12345678'
    expect { click_button 'Sign up'}.to change { User.all.count }.by(1)
  end
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
   page.should have_content "Sign up"
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
