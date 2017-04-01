class TeachingAssistantMailer < ActionMailer::Base

  default from: %Q["#{FROM_EMAIL_NAME}" <#{FROM_EMAIL}>]
  layout 'mailer'

  def welcome(ta)
    @ta = ta
    mail(to: @ta['email'], subject: "#{CHAPTER_NAME}: Your TA application is approved!")
  end

  def pending(ta)
    @ta = ta
    mail(to: @ta['email'], subject: "#{CHAPTER_NAME}: Application received")
  end

  def monthly(ta, courses, month)
    @ta = ta
    @courses = courses
    mail(to: @ta['email'], subject: "#{CHAPTER_NAME} Upcoming TA Opportunities")
  end

  def forgot(ta)
    @ta = ta
    mail(to: @ta['email'], subject: "Here's your private sign up page")
  end
end
