Rails.application.routes.draw do
  root 'static_pages#home'

  get '/groups', to: 'groups#home'
  get '/groups/new', to: 'groups#new'
  post '/groups/new/submit', to: 'groups#submit'
  get '/group/:id', to: 'groups#show', as: 'group_page'
  get '/group/:id/newEvent', to: 'events#new'
  get '/group/:id/about', to: 'groups#about', as: 'group_about'

  get '/events', to: 'events#home'
  post '/events/new/submit', to: 'events#submit'
  get 'event/:id', to: 'events#show', as: 'event_page'

  get '/profile/:id', to: 'profiles#show', as: 'profile'
  get '/signup',  to: 'users#new'
  get '/tos', to: 'static_pages#tos'
  get '/privacy', to: 'static_pages#privacy'

  post '/group/:id/apply', to: 'groups#apply'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
