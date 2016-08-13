require "rails_helper"

RSpec.describe MainSearchesController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/main_searches/show").to route_to("main_searches#show")
    end

    it "routes to #new" do
      expect(:get => "/main_searches/new").to route_to("main_searches#new")
    end

    it "routes to #create" do
      expect(:post => "/main_searches").to route_to("main_searches#create")
    end

  end
end
