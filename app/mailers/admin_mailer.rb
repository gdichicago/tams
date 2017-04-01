class AdminMailer < ActionMailer::Base
  default to: Proc.new { Admin.pluck(:email) },
          from: %Q["#{FROM_EMAIL_NAME}" <#{FROM_EMAIL}>]

  layout 'mailer'

  def new_ta(ta, screeners)
    @ta = ta
    @about = screeners[:about] || 'Answer not provided.'
    @how = screeners[:how] || 'Answer not provided.'
    @why = screeners[:why] || 'Answer not provided.'
    mail(subject: "[#{CHAPTER_NAME}] New TA application received")
  end
end
