class HostReportsController < ApplicationController
  before_action :get_events

  respond_to :html, :text

  def show
    respond_with(@events)
  end

  def new_mail
  end

  def create_mail
    if mail_params[:mail_to].present?
      ReportMailer.host_event_report(mail_params.merge(event_ids: @events.pluck(:id))).deliver_later
      flash[:success] = "Success"
      redirect_to show_host_report_url(ip: mail_params[:ip])
    else
      flash[:error] = "Error"
      render 'new_mail', locals: { ip: mail_params[:ip] }
    end
  end

private

  def get_events
     @events = Event.not_ignored.by_network(host).most_current(50)
  end

  def host
    @host = params[:ip]
  end

  def mail_params
    params.permit(:utf8, :_method, :authenticity_token, :commit, :id,
      :ip, :mail_to, :mail_cc, :subject, :message).reject{|_, v| v.blank?}
  end
end
