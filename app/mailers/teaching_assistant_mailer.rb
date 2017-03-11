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
    attachments.inline['circle_gdi_logo.png'] = File.read('app/assets/images/circle_gdi_logo.png')
    mail(to: @ta['email'], subject: "#{CHAPTER_NAME} Upcoming TA Opportunities")
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
