class MainSearchesController < ApplicationController
  def new
    add_breadcrumb(t('actions.search'), new_main_search_path)
    @search = MainSearch.new
  end

  def create
    Rails.cache.write("MainSearch/#{current_user.id}", MainSearch.new(search_params.to_h),
                      expires_in: 1.day)
    redirect_to action: "show"
  end

  def show
    search = Rails.cache.read("MainSearch/#{current_user.id}")
    if search.nil?
      @search = MainSearch.new
      render action: 'new'
    else
      add_breadcrumb(t('lackmus.search_result'), show_main_search_path)
      if search.options.fetch(:layout, "") == 'Events'
        @events = search.events
        @filter_info = search.filter_info
        render template: 'main_searches/show_events'
      else
        @signatures = search.signatures
        @filter_info = search.filter_info
        render template: 'main_searches/show_signatures'
      end
    end
  end

private

  def search_params
    params.require(:search).permit(:q, :ip, :sensor, :signature, :http_hostname, :layout).reject{|_, v| v.blank?}
  end
end
