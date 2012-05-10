require "spec_helper"

describe CreditHistoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/credit_histories").should route_to("credit_histories#index")
    end

    it "routes to #new" do
      get("/credit_histories/new").should route_to("credit_histories#new")
    end

    it "routes to #show" do
      get("/credit_histories/1").should route_to("credit_histories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/credit_histories/1/edit").should route_to("credit_histories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/credit_histories").should route_to("credit_histories#create")
    end

    it "routes to #update" do
      put("/credit_histories/1").should route_to("credit_histories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/credit_histories/1").should route_to("credit_histories#destroy", :id => "1")
    end

  end
end
