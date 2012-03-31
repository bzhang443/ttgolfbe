require "spec_helper"

describe HolesController do
  describe "routing" do

    it "routes to #index" do
      get("/holes").should route_to("holes#index")
    end

    it "routes to #new" do
      get("/holes/new").should route_to("holes#new")
    end

    it "routes to #show" do
      get("/holes/1").should route_to("holes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/holes/1/edit").should route_to("holes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/holes").should route_to("holes#create")
    end

    it "routes to #update" do
      put("/holes/1").should route_to("holes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/holes/1").should route_to("holes#destroy", :id => "1")
    end

  end
end
