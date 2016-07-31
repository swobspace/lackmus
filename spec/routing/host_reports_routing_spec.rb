require "rails_helper"

RSpec.describe HostReportsController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/host_reports/show/?ip=192.0.2.5").to route_to("host_reports#show", :ip => "192.0.2.5")
    end

    it "routes to #new_mail" do
      expect(:get => "/host_reports/mail/new?ip=192.0.2.5").to route_to("host_reports#new_mail", :ip => "192.0.2.5")
    end

    it "routes to #create_mail" do
      expect(:post => "/host_reports/mail/?ip=192.0.2.5").to route_to("host_reports#create_mail", ip: "192.0.2.5")
    end

  end
end
