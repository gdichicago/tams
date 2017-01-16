class TeachingAssistantMailer < ActionMailer::Base
  include Resque::Mailer

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
    mail(to: @ta['email'], subject: "#{CHAPTER_NAME}: Monthly TA sign ups - #{month}!")
  end

  def confirmation(ta, course)
    @ta = ta
    @course = course
    mail(to: @ta['email'], subject: "TA Confirmation: #{course['name']}")
  end

  def forgot(ta)
    @ta = ta
    mail(to: @ta['email'], subject: "Here's your private sign up page")
  end
end
