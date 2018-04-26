class Beeeer < ActiveRecord::Base
	acts_as_taggable

	has_many :likes
	has_many :liked_users, through: :likes, source: :user
	
	has_many :reviews
	has_one :product_detail, dependent: :destroy

	def get_similar_beer(beer_id)
	  hashTag = Hashtag.find_by(id: params[:id])                # [追加箇所]
    if hashTag == nil || hashTag.beeeers.empty?                # 「:id」でハッシュタグを検索
      return                                                  #
    else                                                      #
      @beeeers = hashTag.beeeers(true).order("created_at DESC") # そのハッシュタグのツイートを全て取得
    end         
	end

end
