require 'spec_helper'

describe Assignment do
  let!(:c) {User.create :email => "test@test.de", :encrypted_password => "test"}
  let!(:o) {Offer.new :subject => "Test", :body => "test"}
  let!(:a) {Assignment.new :subject => "Test", :body => "Test"}

  it 'should not be valid without a customer and offer' do
  	a.should_not be_valid
  end

  it 'should be valid with customer and offer' do
  	a.customer = c
  	a.offer = o
  	a.should be_valid
  end
end
