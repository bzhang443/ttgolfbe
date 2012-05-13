require "spec_helper"

describe ScoreCardsController do
  describe "routing" do

    it "routes to #index" do
      get("/score_cards").should route_to("score_cards#index")
    end

    it "routes to #new" do
      get("/score_cards/new").should route_to("score_cards#new")
    end

    it "routes to #show" do
      get("/score_cards/1").should route_to("score_cards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/score_cards/1/edit").should route_to("score_cards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/score_cards").should route_to("score_cards#create")
    end

    it "routes to #update" do
      put("/score_cards/1").should route_to("score_cards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/score_cards/1").should route_to("score_cards#destroy", :id => "1")
    end

  end
end
