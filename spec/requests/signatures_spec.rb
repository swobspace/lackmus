require 'rails_helper'

RSpec.describe "Signatures", type: :request do
  describe "GET /signatures" do
    it "works! (now write some real specs)" do
      get signatures_path
      expect(response).to have_http_status(200)
    end
  end
end
