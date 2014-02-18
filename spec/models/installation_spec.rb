require 'spec_helper'

describe Installation do
  let!(:c) {User.create :email => "test@test.de", :encrypted_password => "test"}
  let!(:order) {Order.new :subject => "Test", :body => "Test"}
  let!(:i) {Installation.new :subject => "Test", :body => "Test"}

  it 'should not be valid without a customer and Order' do
  	i.should_not be_valid
  end

  it 'should be valid with customer and offer' do
  	i.customer = c
  	i.order = order
  	i.should be_valid
  end
end