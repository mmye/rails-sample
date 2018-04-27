class RankingsController < ApplicationController
	layout 'ranking_site'
	before_action :like_ranking

	def like_ranking
		ids = Like.group(:beeeer_id).order('count_beeeer_id DESC').limit(5).count(:beeeer_id).keys
		@like_ranking = ids.map{|id| Beeeer.find(id) }
	end

end
