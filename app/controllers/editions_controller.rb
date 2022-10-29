class EditionsController < ApplicationController
  def show
    @events = Predicthq.getOtherEditions(params[:query])
    @events2 = Ticketmaster.getOtherEditions(params[:query])
  end
end