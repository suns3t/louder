class UserNotifierMailer < ApplicationMailer

    # send a signup mail when user signed up
    def send_signup_email(user)
        @user = user
        mail(to: @user.email, subject: "Thanks for signup at Bubble!")
    end
end
