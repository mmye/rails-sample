class Beeeer < ActiveRecord::Base
	acts_as_taggable

	has_many :hashtags, through: :hashtag_beeeers
	has_many :hashtag_beeeers
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
