require 'spec_helper'

describe "Bugreports" do
  describe "GET /bugreports" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get bugreports_path
      response.status.should be(302)
    end
  end
end
