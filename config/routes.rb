Rails.application.routes.draw do
	devise_for :users
	root 'beeeer#index'
	get 'beeeer/search' => 'beeeer#search'
	resources :users, only: :show

	resources :beeeer, only: [:index, :show], constraints: { id: /\d+/ } do
		resources :likes, only: [:create, :destroy]
		resources :reviews, only: [:update, :destroy, :new, :create]
	end
	get 'beeeer/:tag_name', to: 'beeeer#tag', as: 'tag'

end
