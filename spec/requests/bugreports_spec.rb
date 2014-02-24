require 'spec_helper'

describe "Bugreports" do
  describe "GET /bugreports" do
  	 let!(:superadmin){FactoryGirl.create(:superadmin)}
    it "works! (now write some real specs)" do
    	login(superadmin)
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get bugreports_path
      response.status.should be(200)
    end
  end
end
