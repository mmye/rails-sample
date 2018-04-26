Rails.application.routes.draw do
	devise_for :users
	root 'beeeer#index'
	get 'beeeer/search' => 'beeeer#search'
	resources :users, only: :show

	resources :beeeer, only: [:index, :show] do
		resources :likes, only: [:create, :destroy]
		resources :reviews
	end
	
end 
