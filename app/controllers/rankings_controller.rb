class RankingsController < ApplicationController
	layout 'ranking_site'
	before_action :ranking

	def ranking
		ids = Review.group(:beeeer_id).order('count_beeeer_id DESC').limit(5).count(:beeeer_id).keys
		@ranking = ids.map{|id| Beeeer.find(id) }
	end
end
