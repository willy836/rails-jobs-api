Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'jobs/index'
      get 'jobs/show'
      get 'jobs/create'
      get 'jobs/update'
      get 'jobs/destroy'
      get 'sessions/login'
      get 'registrations/register'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
