class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.caregiver_invite.subject
  #
  def caregiver_invite(user)
    @user = user
    @greeting = "Hi"

    mail to: "to@example.org", subject: "Invite to View #{@user.first_name @user.lastname}\'s Online Health Record."
  end
end
