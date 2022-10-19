class SegnalaCsController < ApplicationController
    before_action :authorized
    before_action :set_segnala_c, only: %i[ show edit update destroy elimina_commento blocca_utente ]

    def index
        @reported_comments = SegnalaC.all
    end


    def create

        print '99999999999999999999999999999999999999999999999999999'
        if user_signed_in?
            @segnala_c = current_user.segnala_cs.new(segnala_c_params)

            if !@segnala_c.save
                flash[:notice]= @segnala_c.errors.full_messages.to_sentence
            end

        #redirect_to @segnala_c.comment
            redirect_back(fallback_location: root_path)
        else
            print "non logggattooooooooooooooooooooooooooooooooo"
            flash.now[:alert] = 'iscriviti per poter segnalare i commenti'
            redirect_to event_path(segnala_c_params[:comment_id]), alert: 'iscriviti per poter segnalare i commenti'
        end
        
    end


    def destroy
        @seg.destroy

        respond_to do |format|
            format.html { redirect_to segnala_cs_url, notice: "La segnalazione è stata eliminata con successo." }
            format.json { head :no_content }
        end
    end

    def elimina_commento
        Comment.find(@seg.comment_id).destroy

        respond_to do |format|
            format.html { redirect_to segnala_cs_url, notice: "Il commento è stato eliminato con successo." }
            format.json { head :no_content }
        end
    end

    def blocca_utente
        # bloccare l'utente
        puts @seg
        # 

        respond_to do |format|
            format.html { redirect_to segnala_cs_url, notice: "L'utente è stato bloccato con successo." }
            format.json { head :no_content }
        end
    end

    private

    def set_segnala_c
        @seg = SegnalaC.find(params[:id])
    end

    def segnala_c_params
        params.require(:segnala_c).permit(:comment_id)
    end

    def authorized
        
    end
end
