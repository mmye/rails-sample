Rails.application.routes.draw do
	root 'beeeer#index'

	resources :product_detail, only: [:show]
end 
