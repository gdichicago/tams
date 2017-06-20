Rails.application.routes.draw do
  # ROOT
  root 'home#index'

  # SESSIONS
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # ADMIN
  get '/dashboard', to: 'admins#dashboard', as: 'admins_dashboard'

  # TEACHING ASSISTANTS
  get '/teaching_assistants/thanks', to: 'teaching_assistants#thanks', as: 'teaching_assistant_thanks'
  resources :teaching_assistants, param: :private_id, only: [:index, :new, :create, :show, :update]

  # COURSES
  resources :courses
  get '/courses/:id/ta_list', to: 'courses#ta_list', as: 'course_ta_list'

  # HOURS
  resources :hours, only: [:new, :edit, :create, :update, :destroy]

  # EMAILS
  get '/emails/welcome', to: 'emails#welcome', as: 'welcome_emails'
  get '/emails/monthly', to: 'emails#monthly', as: 'monthly_emails'
end
