require "spec_helper"

describe BugreportsController do
  describe "routing" do

    it "routes to #index" do
      get("/bugreports").should route_to("bugreports#index")
    end

    it "routes to #new" do
      get("/bugreports/new").should route_to("bugreports#new")
    end

    it "routes to #show" do
      get("/bugreports/1").should route_to("bugreports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bugreports/1/edit").should route_to("bugreports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bugreports").should route_to("bugreports#create")
    end

    it "routes to #update" do
      put("/bugreports/1").should route_to("bugreports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bugreports/1").should route_to("bugreports#destroy", :id => "1")
    end

  end
end
