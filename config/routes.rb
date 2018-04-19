Rails.application.routes.draw do
	root 'beeeer#index'

	get 'beeeer/search' => 'beeeer#search'
	resources :beeeer, only: [:index, :show]

	resources :product_detail, only: [:show]
end 
