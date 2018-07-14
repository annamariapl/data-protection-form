Rails.application.routes.draw do

  # resources :agreements, only: :show
  #resources :agreements, only: [:show], format: 'docx'
  resources :agreement_templates do
    resources :agreements, only: [:new, :create]
  end

  root to: 'pages#home'
  get 'agreements/:id', to: 'agreements#show', as: 'agreement', format: 'docx'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
