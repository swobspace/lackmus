require 'rails_helper'

RSpec.describe HostReportsController, type: :controller do
  login_admin

  let(:host) { '192.0.2.9' }
  let(:mail) { 'mailto@example.com' }
  let(:events) { FactoryGirl.create_list(:event, 3, src_ip: host) }

  describe "GET #show" do
    it "assigns selected events as @events" do
      get :show, ip: host
      expect(assigns(:events)).to eq(events)
    end
  end

  describe "GET #new_mail" do
    it "assigns host as @host" do
      get :new_mail, ip: host
      expect(assigns(:host)).to eq(host)
    end
  end

  describe "POST #create_mail" do
    context "with valid params" do
      it "sends a new mail" do
        expect { 
          post :create_mail, {ip: host, mail_to: mail, subject: "MySubjectForReport"}
         }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "redirects to host_reports#show" do
        post :create_mail, {ip: host, mail_to: mail}
        expect(response).to redirect_to(show_host_report_path(ip: host))
      end
    end

    context "with invalid params" do
      it "re-renders the 'new' template" do
        post :create_mail, {ip: host, mail_to: nil}
        expect(response).to render_template("new_mail")
      end
    end
  end

end
