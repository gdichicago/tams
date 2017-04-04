# Teaching Assistant Management System (TAMS)
Girl Develop It Chicago uses TAMS to keep track of TA information, as well as allow our users to sign up as TAs for courses. TAMS admins can add new classes, add/remove TAs from courses, send monthly course reminder emails to TAs, among other things.

## How It Works
When a new TA signs up, they will receive a signup confirmation email and their status is set to "prospective". TAMS admins will also receive an email with the prospective TA's application information. A TAMS admin has to login to approve the new TA's application.

When a new class is available on Meetup, a TAMS admin will add the course (via the Meetup URL, which uses the Meetup API to grab pertinent course information) and inputs how many TAs are needed for this particular course.

About once a month, a TAMS admin can use the "monthly course emails" feature on the homepage to send an email to all active TAs.

## How To Run Locally
From the directory where you've cloned the repo, use the following commands:

```
bundle install
bundle exec rake db:setup
rails s
```

## How to Add an Admin Account
Start the rails console with `rails c`

In the console use

```
a = Admin.create :name => "[name]", :password => "[password]", :email=> "[email address]"
```

to input information and credentials for the new admin, then

```
a.save
```

to create the new user.

## How To Deploy
Merging into the `master` automatically deploys your changes to Heroku.
