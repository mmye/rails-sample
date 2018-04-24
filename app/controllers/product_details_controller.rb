class ProductDetailsController < ApplicationController
	def show
		@beer = Beeeer.find(params[:id])
	end
end
