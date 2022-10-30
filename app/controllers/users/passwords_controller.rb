# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController

  #verificare anche che provider==nil !!!!!!!!!!!!!!!!!!!!!
  before_action :authenticate_user!
  before_action :set_user

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update

    if params[:user][:password].present? && params[:user][:password_confirmation].present? && (@edit_mode || params[:user][:current_password].present?)

      if @edit_mode || @user_registration.valid_password?(params[:user][:current_password])


        if @user_registration.update(password: params[:user][:password],password_confirmation:  params[:user][:password_confirmation])
          redirect_to '/home', notice: 'password aggiornata con successo'
        else
          redirect_to edit_user_registration_path(@user_registration), alert: 'errore aggiornamento password'
        end
      else
        redirect_to edit_user_registration_path(@user_registration), alert: 'password corrente sbagliata'
      end

    else
      redirect_to edit_user_registration_path(@user_registration), alert: 'errore aggiornamento password'
    end
    #super

  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  private

  def set_user

    
    if current_user.role=='admin' && (params[:user].present? && (params[:user][:id].present?)) 
      print 'EDIT MODE!!!'
      @edit_mode=true;
      @user_registration=User.find(params[:user][:id])
           
    else
      @edit_mode=false
      @user_registration = User.find(current_user.id)    
    end
           
  end

  def user_pass_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

end
