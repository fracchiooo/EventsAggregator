class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    @user=User.find(@comment.user_id)

    #@likes=@comment.like_comments.all;


  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create

    print 'createeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
    print comment_params[:event_id]

    if user_signed_in?
      @user=current_user
      @comment=@user.comments.create(comment_params)


      respond_to do |format|
        if @comment.save
        #format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
        #format.json { render :show, status: :created, location: @comment }
          format.html { redirect_to event_path(@comment.event_id), notice: "Comment was successfully created." }
          format.json { head :no_content }
        else
          format.html { render :pages/home, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else     
      event=Event.find_by id: comment_params[:event_id]
      redirect_to event_path(event.event_id), alert: "è necessario iscriversi per poter commentare" 
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    print 'updateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
    if user_signed_in?
      respond_to do |format|
        if !(current_user.id==@comment.user_id || current_user.role=='admin')
          format.html { redirect_to root_path, alert: "non autorizzato alla update." }
          format.json { head :no_content }
        elsif @comment.update(comment_params)
        #format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        #format.json { render :show, status: :ok, location: @comment }
          format.html { redirect_to event_path(@comment.event_id), notice: "Comment was successfully updated." }
          format.json { head :no_content }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else     
      event=Event.find_by id: comment_params[:event_id]
      redirect_to event_path(event.event_id), alert: "è necessario iscriversi per poter aggiornare un commento"
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy

    if user_signed_in?
      respond_to do |format|
        if !(current_user.id==@comment.user_id || current_user.role=='admin')
          format.html { redirect_to root_path, alert: "non autorizzato alla destroy." }
          format.json { head :no_content }
        else
        @comment.destroy
      #format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      #format.json { head :no_content }
        format.html { redirect_to event_path(@comment.event_id), notice: "Comment was successfully destroyed." }
        format.json { head :no_content }
        end
      end
    else     
      event=Event.find_by id: comment_params[:event_id]
      redirect_to event_path(event.event_id), alert: "è necessario iscriversi per poter eliminare un commento"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
        
      @comment = Comment.find(params[:event_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params

      if params[:id]
        event= Event.find_by event_id: params[:id]
        params.require(:comment).permit(:testo).merge(event_id: event.id, id: params[:event_id])

      else
        params.require(:comment).permit(:testo).merge(event_id: params[:event_id])
    
      end
    end
end
