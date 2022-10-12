class LikeCommentsController < ApplicationController

    def create
        if user_signed_in?
            @like_comment = current_user.like_comments.new(like_c_params)
            if !@like_comment.save
            flash[:notice]= @like_comment.errors.full_messages.to_sentence
            end

        #redirect_to @like_comment.comment  # dovrò mettere il redirect all evento a cui appartiene il commento
        #redirect_to root_path(param_1: "#{@like_comment.comment_id}")
            redirect_back(fallback_location: event_path(params[:event_id]))
        else
            #redirect_to event_path(like_c_params[:comment_id]), alert: "è necessario iscriversi per poter mettere like a un commento"
            #respond_to do |format|
               # format.html {redirect_to event_path(params[:event_id]), alert: "Comment was successfully updated"}
                #format.json {head :no_content }
            #end
            #redirect_to event_path(params[:event_id]), flash: {alert: "tu madre"}
            flash.now[:alert] = 'iscriviti per poter mettere like ai commenti'
            redirect_to event_path(params[:event_id]), alert: 'iscriviti per poter mettere like ai commenti'
        end
    end

    def destroy

        if user_signed_in?
            @like_comment= current_user.like_comments.find(params[:id]) #dovrò inserire un nuovo modo per passargli l id del commento
            comment = @like_comment.comment # dovrò mettere l evento al posto del commento
            @like_comment.destroy
        #redirect_to root_path(param_1: "#{comment.id}")

            redirect_back(fallback_location: event_path(params[:event_id]))
        else
            #redirect_to event_path(like_c_params[:comment_id]), alert: "è necessario iscriversi per poter mettere like a un commento"
            
            flash.now[:alert] = 'iscriviti per poter mettere togliere i like ai commenti'
            redirect_to event_path(params[:event_id]), alert: 'iscriviti per poter mettere togliere i like ai commenti'
        end


    end


    private

    def like_c_params
        params.require(:like_comment).permit(:comment_id)
    end

end
