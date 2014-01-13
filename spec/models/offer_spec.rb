require 'spec_helper'

describe Offer do
  

  let!(:c) {User.create :email => "test@test.de", :encrypted_password => "test"}
  let!(:r) {Request.new :subject => "Test", :body => "test", :urgency => "1"}
  let!(:o) {Offer.new :subject => "Test", :body => "test"}

  it 'should not be valid without a customer and request' do
  	o.should_not be_valid
  end

  it 'should be valid with customer' do
  	r.customer = c
  	o.customer = c
  	o.request = r
  	o.should be_valid
  end

end
