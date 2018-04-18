class BeeeerController < ApplicationController

  def index
		@beers = Beeeer.order('item_name ASC').page(params[:page]).per(20)
  end
end
