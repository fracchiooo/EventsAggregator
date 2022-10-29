class UserMailer < ApplicationMailer
  default from: 'no-reply@eventsaggregator.com'

  #esempio di utilizzo
  # UserMailer.with(user: @user, link: 'https://...').reset_password.deliver_now
  def reset_password
    @user = params[:user]
    @link  = params[:link]
    mail(to: @user.email, subject: 'Password reset')
  end
end