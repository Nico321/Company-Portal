require "spec_helper"

describe BusinessprocessesController do
  describe "routing" do

    it "routes to #index" do
      get("/businessprocesses").should route_to("businessprocesses#index")
    end

    it "routes to #new" do
      get("/businessprocesses/new").should route_to("businessprocesses#new")
    end

    it "routes to #show" do
      get("/businessprocesses/1").should route_to("businessprocesses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/businessprocesses/1/edit").should route_to("businessprocesses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/businessprocesses").should route_to("businessprocesses#create")
    end

    it "routes to #update" do
      put("/businessprocesses/1").should route_to("businessprocesses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/businessprocesses/1").should route_to("businessprocesses#destroy", :id => "1")
    end

  end
end
