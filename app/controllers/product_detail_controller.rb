class ProductDetailController < ApplicationController
	def show
		@beer = Beeeer.find(params[:id])
	end
end
