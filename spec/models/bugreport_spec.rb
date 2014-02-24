require 'spec_helper'

describe Bugreport do
  let!(:cu){FactoryGirl.create(:superadmin)}
  let!(:bugreport) {Bugreport.create(subject: "new Subject", description: "new description", reporter: nil)}

  it "is not valid without a reporter" do
  	bugreport.should_not be_valid
  end

  it "is valid with a reporter" do
  	bugreport.reporter_id = cu.id
  	bugreport.should be_valid
  end
end