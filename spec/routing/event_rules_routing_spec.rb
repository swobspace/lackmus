require "rails_helper"

RSpec.describe EventRulesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/event_rules").to route_to("event_rules#index")
    end

    it "routes to #new" do
      expect(:get => "/event_rules/new").to route_to("event_rules#new")
    end

    it "routes to #show" do
      expect(:get => "/event_rules/1").to route_to("event_rules#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/event_rules/1/edit").to route_to("event_rules#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/event_rules").to route_to("event_rules#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/event_rules/1").to route_to("event_rules#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/event_rules/1").to route_to("event_rules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/event_rules/1").to route_to("event_rules#destroy", :id => "1")
    end

  end
end
