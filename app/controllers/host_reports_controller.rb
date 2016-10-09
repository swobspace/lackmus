class HostReportsController < ApplicationController
  before_action :get_events

  respond_to :html, :text

  def show
    respond_with(@events)
  end

  def new_mail
    @is_form = true
    @message = "Unchecked events are always done"
  end

  def create_mail
    if mail_params[:mail_to].present?
      ReportMailer.host_event_report(mail_params.merge(event_ids: event_ids)).deliver_later
      if mark_done?
        Event.where(['id IN (?)', event_ids]).update_all(done: true)
      end
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

  def event_ids
    params[:event_ids] || []
  end

  def mark_done?
   params[:mark_done].present?
  end

  def host
    @host = params[:ip]
  end

  def mail_params
    params.permit(:utf8, :_method, :authenticity_token, :commit, :id,
      :ip, :mail_to, :mail_cc, :subject, :message).reject{|_, v| v.blank?}
  end
end
