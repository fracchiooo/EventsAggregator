class SegnalaCsController < ApplicationController

    def create
        @segnala_c = current_user.segnala_cs.new(segnala_c_params)

        if !@segnala_c.save
            flash[:notice]= @segnala_c.errors.full_messages.to_sentence
        end

        #redirect_to @segnala_c.comment
        redirect_back(fallback_location: root_path)

        
    end


    private

    def segnala_c_params
        params.require(:segnala_c).permit(:comment_id)
    end
end
