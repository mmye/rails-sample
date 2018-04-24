Rails.application.routes.draw do
	devise_for :users
	get 'beeeer/search' => 'beeeer#search'
	resources :users, only: :show
	resources :beeeer, only: [:index, :show] do
		resources :reviews
	end
	root 'beeeer#index'
	
end 
