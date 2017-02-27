# TODO: RESQUE SETUP

Rails.application.routes.draw do
  root 'sessions#new'

  resources :series, only: [:new, :create]

  resources :hours, only: [:new, :edit, :create, :update, :destroy]

  resources :courses
  get '/courses/:id/ta_list', to: 'courses#ta_list', as: 'course_ta_list'

  get '/teaching_assistants/thanks', to: 'teaching_assistants#thanks', as: 'teaching_assistant_thanks'
  resources :teaching_assistants, param: :private_id, only: [:index, :new, :create, :show, :update]

  resources :sessions, only: [:new, :create, :destroy]
  post '/', to: 'sessions#create'

  # ADMIN FUNCTIONS
  get '/dashboard', to: 'admins#dashboard', as: 'admins_dashboard'
  get '/upcoming', to: 'admins#upcoming', as: 'admins_upcoming_courses'

  # EMAIL SENDS
  get '/emails/welcome', to: 'emails#welcome', as: 'welcome_emails'
  get '/emails/monthly', to: 'emails#monthly', as: 'monthly_emails'
  get '/emails/confirmation', to: 'emails#confirmation', as: 'confirmation_emails'
  get '/emails/missing_confirmation', to: 'emails#missing_confirmation', as: 'missing_confirmation_emails'
end
