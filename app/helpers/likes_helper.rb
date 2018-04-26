module LikesHelper
  def likes_count(beer_id)
    likes = Like.where(beeeer_id: beer_id).count
  end
end
