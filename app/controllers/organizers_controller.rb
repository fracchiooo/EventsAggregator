class OrganizersController < ApplicationController
  def show
    @events = Predicthq.getEventsByOrganizer(params[:organizer_id])
    @events2 = Ticketmaster.getEventsByOrganizer(params[:organizer_id])

    if @events.present?
      @organizer = @events.first['entities'].first['name']
      @total_events = @events.length
    elsif @events2.present?
      @organizer = @events2.first['promoter']['name']
      @total_events = @events2.length
    end

    @total_partecipants = Partecipant.where(organizer_id: params[:organizer_id]).count

    @total_likes = 0
    LikeEvent.where(promoter: params[:organizer_id]).each do |like|
      if like.like
        @total_likes = @total_likes + 1
      elsif like.like == false
        @total_likes = @total_likes - 1
      end
    end


  end
end