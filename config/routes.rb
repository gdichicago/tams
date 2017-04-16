Rails.application.routes.draw do
  root 'sessions#new'

  resources :hours, only: [:new, :edit, :create, :update, :destroy]

  resources :courses
  get '/courses/:id/ta_list', to: 'courses#ta_list', as: 'course_ta_list'

  get '/teaching_assistants/thanks', to: 'teaching_assistants#thanks', as: 'teaching_assistant_thanks'
  resources :teaching_assistants, param: :private_id, only: [:index, :new, :create, :show, :edit, :update]

  resources :sessions, only: [:new, :create, :destroy]
  post '/', to: 'sessions#create'

  # ADMIN FUNCTIONS
  get '/dashboard', to: 'admins#dashboard', as: 'admins_dashboard'

  # EMAIL SENDS
  get '/emails/welcome', to: 'emails#welcome', as: 'welcome_emails'
  get '/emails/monthly', to: 'emails#monthly', as: 'monthly_emails'
end
