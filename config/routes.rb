Rails.application.routes.draw do

  root 'tasks#index'
  resources :tasks
  patch '/tasks/:id/complete' => 'tasks#complete', as: 'task_complete'
  get 'auth/github/callback' => 'sessions#create'
  get '/auth/login' => 'sessions#login', as: 'login'
  delete "/logout", to: "sessions#logout", as: "logout"
  post '/tasks/:id/edit', to: 'tasks#edit'
  delete '/sessions', to: 'sessions#destroy'
end
