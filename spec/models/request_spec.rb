require 'spec_helper'

describe Request do

  let!(:c) {User.create :email => "test@test.de", :encrypted_password => "test"}
  let!(:r) {Request.new :subject => "Test", :body => "test", :urgency => "1"}

  it 'should not be valid without a customer' do
  	r.should_not be_valid
  end

  it 'should be valid with customer' do
  	r.customer = c
  	r.should be_valid
  end

end
