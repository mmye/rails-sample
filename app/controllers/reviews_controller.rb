class ReviewsController < BeeeerController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :set_beer_tags_to_gon, only: [:new]

	def new
		@review = Review.new
	end

	def create
		Review.create(review_params)
		@beer = Beeeer.find(params[:beeeer_id])
		@beer.update(tag_list: params[:beer][:tag_list])
		redirect_to controller: :beeeer, action: :index
	end

	private
	def review_params
		params.require(:review).permit(:rate, :review).merge(beeeer_id: params[:beeeer_id], user_id: '1')
	end

	def tag_params
		params.permit(:beer)
	end

	def set_beer_tags_to_gon
		@beer = Beeeer.find(params[:beeeer_id])
		gon.beer_tags= @beer.tag_list
	end
end
