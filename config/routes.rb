Rails.application.routes.draw do

  root 'tasks#index'
  patch '/tasks/:id/complete' => 'tasks#complete', as: 'task_complete'
  get 'auth/github/callback' => 'sessions#create'
  get '/auth/login' => 'sessions#login', as: 'login'
  delete "/logout", to: "sessions#logout", as: "logout"


  get '/tasks' => 'tasks#index'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks/new', to: 'tasks#new'
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  post '/tasks/:id/edit', to: 'tasks#edit'
  patch '/tasks/:id' => 'tasks#update'
  post '/tasks' => 'tasks#create'
  delete '/tasks/:id' => 'tasks#destroy'
  get '/tasks/:id/complete' => 'tasks#update'
  get '/sessions/login_failure', to: 'sessions#login_failure', as: 'login_failure'
  get '/sessions', to: 'sessions#index', as: 'sessions'
  delete '/sessions', to: 'sessions#destroy'

end
