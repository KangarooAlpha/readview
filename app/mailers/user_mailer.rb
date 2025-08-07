class UserMailer < ApplicationMailer
  default from: "no-reply@yourapp.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Odinbook!")
  end
end
