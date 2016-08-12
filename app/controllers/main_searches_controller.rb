class MainSearchesController < ApplicationController
  def new
    @search = MainSearch.new
  end

  def create
    @events = MainSearch.new(search_params).events
  end

  def show
  end

private

  def search_params
    params.require(:search).permit(:q, :ip)
  end
end
