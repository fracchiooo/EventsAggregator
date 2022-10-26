class UsersController < ApplicationController
  before_action :authorized
  before_action :set_user, only: %i[ show edit update destroy blocca_utente rendi_amministratore ]

  def index
    @users = User.all
    @current = current_user
  end

  def destroy
    @user.destroy

    respond_to do |format|
        format.html { redirect_to users_url, notice: "L'utente è stato eliminato con successo." }
        format.json { head :no_content }
    end
  end

  def blocca_utente
    # utente non bloccato -> da bloccare
    if @user.account_active
      @user.update_attribute(:account_active, false)

      respond_to do |format|
          format.html { redirect_to users_url, notice: "L'utente è stato bloccato con successo." }
          format.json { head :no_content }
      end
    # utente bloccato -> da sbloccare
    else
      @user.update_attribute(:account_active, true)

      respond_to do |format|
          format.html { redirect_to users_url, notice: "L'utente è stato sbloccato con successo." }
          format.json { head :no_content }
      end
    end
  end

  def rendi_amministratore
    @user.update_attribute(:role, 'admin')
  
    respond_to do |format|
      format.html { redirect_to users_url, notice: "L'utente è stato reso amministratore con successo." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
      params.require(:user).permit(:user_id)
  end

  def authorized
    if current_user.blank? || current_user.role != 'admin'
      render :file => "public/404.html", :status => :unauthorized
    end 
  end
end
