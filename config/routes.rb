Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]

  resources :courses, only: [:new, :create, :index, :edit, :update]
  get '/courses/:id/ta_list', to: 'courses#ta_list', as: 'course_ta_list'

  # ADMIN
  get '/dashboard', to: 'admins#dashboard', as: 'admins_dashboard'
end
