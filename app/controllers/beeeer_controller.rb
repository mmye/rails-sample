class BeeeerController < RankingsController

  def index
		@beers = Beeeer.order('item_name ASC').page(params[:page]).per(20)
		@like = Like.new
		@likes = Like.includes(:user).all
		gon.available_tags = []
  end

	def tag
    @tag_name = params[:tag_name]
    @beers = Beeeer.tagged_with(params[:tag_name]).page(params[:page]).per(20)
    @like = Like.new
	end

	def show
		@beer = Beeeer.find(params[:id])
		@detail = @beer.product_detail
	end

	def search
		@beers = Beeeer.where('item_name LIKE(?)', "%#{params[:keyword]}%").order('item_name ASC').page(params[:page]).per(20)
		@keyword = params[:keyword]
	end


end
