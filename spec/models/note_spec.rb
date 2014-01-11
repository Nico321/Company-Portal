require 'spec_helper'

describe Note do
  let!(:c) {User.create :email => "test@test.de", :encrypted_password => "test"}
  let!(:r) {Request.new :subject => "Test", :body => "test", :urgency => "1"}
  let!(:n) {Note.new :subject => "Test", :body => "test"}

  it 'should not be valid without a customer and request' do

  	n.should_not be_valid
  end

  it 'should be valid with customer and request' do
  	n.user = c
  	n.request = r

  	n.should be_valid
  end
end