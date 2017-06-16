Rails.application.routes.draw do
  # Root
  get '/', to: 'home#index'

  # Teaching Assistants
  get 'ta/new', to: 'teaching_assistant#new'
end
