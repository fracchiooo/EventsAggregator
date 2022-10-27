class PartecipantsController < ApplicationController
  def update
    selected_event = Event.find(params[:event])
    partecipant = Partecipant.where(event: selected_event, user: current_user)

    if partecipant.empty? 
      partecipant = Partecipant.create(event: selected_event, user: current_user)
      respond_to do |format|
        if partecipant.save
          format.html {redirect_to event_path(selected_event.event_id)}
          format.json {head :no_content}
        else
          format.html { redirect_to events_path, status: :unprocessable_entity }
          format.json { head :no_content }
        end
      end
    else
      partecipant.destroy_all
      respond_to do |format|
        format.html {redirect_to  event_path(selected_event.event_id)}
        format.json {head :no_content}
      end
    end
  end
end

