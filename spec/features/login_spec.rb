require 'spec_helper'

describe 'Sign_up' do
  before(:each) do
  visit root_path
 end

 it 'allows to sign up' do
  click_link 'Sign up'
  fill_in "user_email", with: 'kunde@example.de'
  fill_in "user_password", with: '12345678'
  fill_in "user_password_confirmation", with: '12345678'
 
  expect { click_button 'Sign up'}.to change { User.count }.by(1)
 end

 context 'existing user' do
  let!(:user) {FactoryGirl.create :user}
  
  before(:each) do
   sign_in_user
  end
  
  it 'allows to sign in' do   
  end
 
  it 'allows to sign out' do   
   click_link 'Sign out'

  end

  it 'allows change passwort' do   
   click_link 'change password'
   fill_in "user_password", with: "testtest"
   fill_in "user_password_confirmation", with: "testtest"
   fill_in "user_current_password", with: "12345678"
   click_button "Update"
   page.should have_content "You updated your account successfully."
  end
 end

end
