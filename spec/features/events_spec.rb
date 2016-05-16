require 'rails_helper'

RSpec.describe "Events", type: :feature do
  describe "GET /events" do
    it "visits events#index" do
      login_user
      visit events_path
      expect(current_path).to eq(events_path)
    end
  end
end
