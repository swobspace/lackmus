require 'rails_helper'

RSpec.describe "Signatures", type: :feature do
  describe "GET /signatures" do
    it "visits signatures#index" do
      login_user
      visit signatures_path
      expect(current_path).to eq(signatures_path)
    end
  end
end
