Rails.application.routes.draw do
  root 'static_pages#home'

  get '/groups', to: 'groups#home'
  get '/groups/new', to: 'groups#new'
  post '/groups/new/submit', to: 'groups#submit'
  get '/group/:id/newEvent', to: 'events#new'
  get '/group/:id', to: 'announcements#index', as: 'group_page'
  post '/group/:id', to:'announcements#create'
  get '/group/:id/apply', to: 'announcements#new', as: 'new_announcement'
  get '/group/:group_id/announcement/edit', to:'announcements#edit', as:'edit_announcement'

  get '/events', to: 'events#home'
  post '/events/new/submit', to: 'events#submit'
  get 'event/:id', to: 'events#show', as: 'event_page'

  get '/profile/:id', to: 'profiles#show', as: 'profile'
  get '/signup',  to: 'users#new'
  get '/tos', to: 'static_pages#tos'
  get '/privacy', to: 'static_pages#privacy'

  post '/group/:id/apply', to: 'groups#apply', as: 'apply_to_group'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
