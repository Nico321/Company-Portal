require 'spec_helper'

describe Order do
  let!(:c) {User.create :email => "test@test.de", :encrypted_password => "test"}
  let!(:o) {Offer.new :subject => "Test", :body => "test"}
  let!(:a) {Assignment.new :subject => "Test", :body => "Test"}
  let!(:order) {Order.new :subject => "Test", :body => "Test"}

  it 'should not be valid without a customer and offer' do
  	order.should_not be_valid
  end

  it 'should be valid with customer and offer' do
  	order.customer = c
  	order.should be_valid
  end
end
