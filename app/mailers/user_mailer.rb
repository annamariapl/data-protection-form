class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.report.subject
  #
  def report(file)
    @greeting = "Hi"

    attachments['report.docx'] = File.read(file)

    mail(
      to: "annamaria.wojtyga@gmail.com",
      subject: 'Welcome to My Awesome Site',
      attachments: attachments
    )
  end
end
