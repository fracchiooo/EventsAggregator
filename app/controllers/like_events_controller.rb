class LikeEventsController < ApplicationController

    def create
        @like_event = current_user.like_events.new(event_params)
          
        begin
          respond_to do |format|
            if @like_event.save
              format.html { redirect_to event_path(@like_event.event.event_id) }
              format.json { render :show, status: :created, location: @like_event }
            else
              format.html { redirect_to event_path(@like_event.event.event_id) }
              format.json { render json: @like_event.errors, status: :unprocessable_entity }
            end
          end

        # utente ha già votato una volta questo evento
        rescue ActiveRecord::RecordNotUnique
          @event_like_already_existing = LikeEvent.find_by(user_id: current_user.id, event_id: params[:like_event][:event_id])

          if params[:like_event][:like] == 'true' && ( !@event_like_already_existing.like || @event_like_already_existing.like == nil ) 
            @event_like_already_existing.update_attribute(:like, 'true')
          elsif params[:like_event][:like] == 'false' && ( @event_like_already_existing.like || @event_like_already_existing.like == nil )
            @event_like_already_existing.update_attribute(:like, 'false')
          elsif
            # se l'utente clicca sullo stesso pulsante che aveva selezionato, toglie il suo voto => nella tupla inserisco nil (non elimino la tupla)
            @event_like_already_existing.update_attribute(:like, nil)
          end

          respond_to do |format|
            format.html { redirect_to event_path(@like_event.event.event_id) } # alert: "utente ha già votato" 
            format.json { render json: @like_event.to_json }
          end
        end

    end

    private

    def event_params
      params.require(:like_event).permit(:event_id, :promoter, :like)
    end
end
