class FavoritesController < ApplicationController
  def update
    selected_event = Event.find(params[:event])
    favorite = Favorite.where(event: selected_event, user: current_user)

    if favorite.empty? 
      # Create the favorite

      fav = Favorite.create(event: selected_event, user: current_user)
      favorite_exists = true 
      respond_to do |format|
        if fav.save
          format.html {redirect_to event_path(selected_event.event_id)}
          format.json {head :no_content}
        else
          format.html { redirect_to events_path, status: :unprocessable_entity }
          format.json { head :no_content }
        end
      end
    else
      # Delete the favorite(s)
      favorite.destroy_all
      favorite_exists = false
      respond_to do |format|
        format.html {redirect_to  event_path(selected_event.event_id)}
        format.json {head :no_content}
      end
    end
     
    
    
  end


end

