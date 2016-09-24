require 'rails_helper'

RSpec.describe MainSearchesController, type: :controller do
  let(:signature) { FactoryGirl.create(:signature) }
  let(:signature2) { FactoryGirl.create(:signature) }
  let!(:event1) { FactoryGirl.create(:event, src_ip: '192.0.2.7', signature: signature) }
  let!(:event2) { FactoryGirl.create(:event, dst_ip: '192.0.2.7', signature: signature) }
  let!(:event3) { FactoryGirl.create(:event, dst_ip: '198.51.100.3', signature: signature2) }
  login_admin

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "redirects to show_main_search_path" do
      get :create, search: {q: '192.0.2.7'}
      expect(response).to redirect_to(show_main_search_path)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it "renders 'new' if last search was empty" do
      get :show
      expect(response).to render_template("new")
    end

    it "assigns events to @events" do
      get :create, search: {q: '192.0.2.7', layout: 'Events'}
      get :show
      expect(assigns(:events)).to contain_exactly(event1, event2)
    end

    it "assigns signatures to @signatures" do
      get :create, search: {q: '192.0.2.7'}
      get :show
      expect(assigns(:signatures)).to contain_exactly(signature)
    end

    it "assigns signatures to @signatures" do
      get :create, search: {q: '192.0.2.0/29'}
      get :show
      expect(assigns(:signatures)).to contain_exactly(signature)
    end
  end

end
