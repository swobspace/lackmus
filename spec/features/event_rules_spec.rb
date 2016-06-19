require 'rails_helper'

RSpec.describe "EventRules", type: :feature do
  describe "GET /event_rules" do
    it "visits event_rules#index" do
      login_user
      visit event_rules_path
      expect(current_path).to eq(event_rules_path)
    end
  end
end
