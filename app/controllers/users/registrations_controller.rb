# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  before_action :set_user
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    print 'updateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'

    image_path=params[:user][:immagine_profilo].path


    params[:user].delete :password_confirmation
    params[:user].delete :password
    params[:user].delete :current_password
    params[:user].delete :immagine_profilo




    super


    File.open(image_path,"rb") do |f|

      @user.update(immagine_profilo: Base64.strict_encode64(f.read))

    end




    #imagen=Base64.strict_encode64(image.to_s)
    #print imagen
    #current_user.immagine_profilo=imagen


  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end



  private

  def set_user
        
    @user = User.find(current_user.id)
  end




  def user_params


    params.require(:user).permit(:nome, :cognome, :data_nascita, :immagine_profilo, :username, :email, :password, :sesso)
  
    
  end
end
