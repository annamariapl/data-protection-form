Rails.application.routes.draw do

	resources :agreements, only: :show
	resources :agreement_templates do
		resources :agreements, only: [:new, :create]
	end

	root to: 'agreements#new'
  # get 'agreements/:id', to: 'agreements#show', as: 'agreement', format: 'docx'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
