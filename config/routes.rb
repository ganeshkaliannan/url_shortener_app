Rails.application.routes.draw do
  # root to: 'visitors#index'
  devise_for :users
  resources  :users
  resources :urls , :only => [:destroy,:update]

  get 'home', to: 'urls#index'
  get '/:id' => "urls#show"
  post 'create_short_url', to: 'urls#create_short_url'
  post 'create_short_url', to: 'urls#create_short_url'
  # delete 'destroy', to: 'visitors#destroy_url'


devise_scope :user do
  authenticated :user do
    root 'urls#index', as: :authenticated_root
  end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end
end
