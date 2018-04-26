class BeeeerController < RankingsController

  def index
		@beers = Beeeer.order('item_name ASC').page(params[:page]).per(20)
		@tags = Beeeer.tags_on(:tags)
		@like = Like.new
		@likes = Like.includes(:user).all
		gon.available_tags = []
  end

	def show
		@beer = Beeeer.find(params[:id])
		@detail = @beer.product_detail
	end

	def search
		@beers = Beeeer.where('item_name LIKE(?)', "%#{params[:keyword]}%").order('item_name ASC').page(params[:page]).per(20)
		@keyword = params[:keyword]
	end

	def tag
	end

	def tag_cloud
		@tags = Beeeer.tag_counts_on(:tags).order('count DESC')
	end
end
