class ProfileController < ApplicationController
  def show
    begin
      @user = User.find(params[:id])
      @favorites = Favorite.where(user: @user)
      @partecipants = Partecipant.where(user: @user)
    rescue ActiveRecord::RecordNotFound
      @user = nil
    end
  end
end