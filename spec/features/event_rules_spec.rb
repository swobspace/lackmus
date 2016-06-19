require 'rails_helper'

RSpec.describe "EventRules", type: :request do
  describe "GET /event_rules" do
    it "works! (now write some real specs)" do
      get event_rules_path
      expect(response).to have_http_status(200)
    end
  end
end
