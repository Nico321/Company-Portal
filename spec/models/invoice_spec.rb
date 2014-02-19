require 'spec_helper'

describe Invoice do
  let!(:c) {User.create :email => "test@test.de", :encrypted_password => "test"}
  let!(:inst) {Installation.new :subject => "Test", :body => "Test"}
  let!(:i) {Invoice.new :subject => "Test", :body => "Test"}

  it 'should not be valid without a customer and Installation' do
  	i.should_not be_valid
  end

  it 'should be valid with customer and offer' do
  	i.customer = c
  	i.installation = inst
  	i.should be_valid
  end
end
