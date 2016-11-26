Rails.application.routes.draw do
  root 'home#home'

  get '/groups', to: 'groups#home'
  get '/groups/new', to: 'groups#new'
  post '/groups/new/submit', to: 'groups#submit'
  get '/group/:id/new_event', to: 'events#new'
  post '/group/:id/new_event', to: 'events#submit', as: 'event_create'
  get '/group/:id', to: 'groups#show', as: 'group_page'
  get '/group/:id/edit', to: 'groups#edit_group', as: 'edit_group'
  patch '/group/:id/edit', to: 'groups#update_group', as: 'update_group'
  get '/group/:id/members', to: 'groups#members', as: 'group_members'
  post '/group/:id', to:'announcements#create'
  get '/group/:id/announcement', to: 'announcements#new', as: 'new_announcement'
  get '/group/:id/announcement/edit/:announcement_id', to:'announcements#edit', as: 'edit_announcement'
  delete '/group/:group_id/announcement/:id', to:'announcements#destroy', as: 'delete_announcement'
  patch '/groups/:id/announcement/:announcement_id', to:'announcements#update', as:'update_announcement'
  get '/group/:id/about', to: 'groups#about', as: 'group_about'
  get '/group/:id/about/edit', to: 'groups#edit_about', as: 'edit_about'
  patch '/groups/:id/about/', to:'groups#update_about', as: 'update_about'
  get '/group/:id/events', to: 'groups#events', as: 'group_events'
  get '/group/:id/media', to: 'groups#media', as: 'group_media'
  get '/group/:id/media/edit', to: 'groups#edit_media', as: 'edit_media'
  patch '/groups/:id/media/', to:'groups#update_media', as: 'update_media'
  post '/groups/change_image', to: 'groups#change_image'

  get '/events', to: 'events#home'
  get '/event/:id', to: 'events#show', as: 'event_page'
  post '/event/add_user', to: 'events#add_user'
  post '/event/remove_user', to: 'events#remove_user'

  get '/profile/:id', to: 'profiles#show', as: 'profile'
  get '/profile/:id/edit', to: 'profiles#edit', as: 'edit_profile'
  patch '/profile/:id/submit', to: 'profiles#submit', as: 'submit_profile'
  get '/signup',  to: 'users#new'
  get '/tos', to: 'static_pages#tos'
  get '/privacy', to: 'static_pages#privacy'

  post '/group/:id/apply', to: 'groups#apply', as: 'apply_to_group'
  post '/group/:id/accept_application/:user_id', to: 'groups#accept', as: 'accept_application'
  post '/group/:id/reject_application/:user_id', to: 'groups#reject', as: 'reject_application'
  post '/group/:id/add_admin/:user_id', to: 'groups#add_admin', as: 'add_admin'
  post '/group/:id/remove_member/:user_id', to: 'groups#remove_member', as: 'remove_member'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
