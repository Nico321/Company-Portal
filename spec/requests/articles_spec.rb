require 'spec_helper'

describe "Articles" do
	let!(:superadmin){FactoryGirl.create(:superadmin)}
  describe "GET /articles" do
    it "works! (now write some real specs)" do
    	login(superadmin)
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get articles_path
      response.status.should be(200)
    end
  end
end
