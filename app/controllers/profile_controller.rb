class ProfileController < ApplicationController
  def show
    if !user_signed_in?
      return redirect_to new_user_session_path
    end

    begin
      @user = User.find(params[:id])
      @favorites = Favorite.where(user: @user)
      @partecipants = Partecipant.where(user: @user)
    rescue ActiveRecord::RecordNotFound
      @user = nil
    end
  end
end