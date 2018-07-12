Rails.application.routes.draw do
  resources :agreements, only: :show
  resources :agreement_templates do
    resources :agreements, only: [:new, :create]
  end
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
