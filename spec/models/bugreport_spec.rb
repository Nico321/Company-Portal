require 'spec_helper'

describe Bugreport do
  let!(:cu) {User.create(:id => "12", :email => "test@test.de", :encrypted_password => "test")}
  let!(:bugreport) {Bugreport.create(subject: "new Subject", description: "new description", reporter: nil)}

  it "is not valid without a reporter" do
  	bugreport.should_not be_valid
  end

  it "is valid with a reporter" do
  	bugreport.reporter = cu
  	bugreport.should be_valid
  end
end