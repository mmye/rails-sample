class BeeeerController < RankingsController
	
  def index
		@beers = Beeeer.order('item_name ASC').page(params[:page]).per(20)
  end

	def show
		@beer = Beeeer.find(params[:id])
		@detail = @beer.product_detail
	end

	def search
		@beers = Beeeer.where('item_name LIKE(?)', "%#{params[:keyword]}%").order('item_name ASC').page(params[:page]).per(20)
	end
end
