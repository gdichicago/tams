class AdminMailer < ActionMailer::Base
  include Resque::Mailer

  default to: Proc.new { Admin.pluck(:email) },
          from: %Q["#{FROM_EMAIL_NAME}" <#{FROM_EMAIL}>]

  layout 'mailer'

  def new_ta(ta, screeners)
    @ta = ta
    @about = CGI.escapeHTML(screeners[:about]) || 'Answer not provided.'
    @how = CGI.escapeHTML(screeners[:how]) || 'Answer not provided.'
    @why = CGI.escapeHTML(screeners[:why]) || 'Answer not provided.'
    mail(subject: "#{CHAPTER_NAME}: New TA application received")
  end
end
