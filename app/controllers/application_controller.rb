class ApplicationController < ActionController::Base


    rescue_from "SQLite3::ConstraintException", :with => :error_c_render


    def error_c_render(err)
        respond_to do |format|
            print err
            format.html { redirect_to new_registration_path(resource_name), alert: "username già preso." }
            format.json { head :no_content }
        end
    end

    



    before_action :configure_permitted_params, if: :devise_controller?



    protected

    def configure_permitted_params
        devise_parameter_sanitizer.permit(:sign_up, keys:[:data_nascita, :immagine_profilo, :username, :nome, :cognome, :sesso])
        devise_parameter_sanitizer.permit(:account_update, keys:[:data_nascita, :immagine_profilo, :username, :nome, :cognome, :sesso, :avatar])
    end
end
