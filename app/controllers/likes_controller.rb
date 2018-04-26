class LikesController < ApplicationController
	def create
		@like = Like.new(user_id: current_user.id, beeeer_id: params[:beeeer_id])
		if @like.save
			redirect_to root_path, notice: 'いいねしました'
		else
			redirect_to root_path, alert: 'いいねできませんでした'
		end
	end

	def destroy(beeeer_id)
		like = Like.find_by(beeeer_id: beeeer_id, user_id: current_user.id)
		like.destroy
		redirect_to root_path
	end

end
