Rails.application.routes.draw do
  devise_for :users
  resources :scenarios do
    resources :directions
  end
  resources :directions
  resources :entries
  get 'editor/edit', to: 'editor#edit'
  get 'editor/new', to: 'editor#new'
  post 'preview', to: 'previews#show', as: :preview

  get 'static/index'
  get 'contact', to: 'static#contact'
  get 'admin', to: 'static#admin'
  root 'static#index'
end
