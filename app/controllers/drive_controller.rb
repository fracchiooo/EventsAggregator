class DriveController < ApplicationController
  def add_media
    session[:google_type] = 'drive'

    if session[:authorization].nil?
      return redirect_to oauth2_redirect_url
    end

    return render html: "#TODO"

  end
end