class Beeeer < ActiveRecord::Base
	acts_as_taggable

	has_many :likes
	has_many :liked_users, through: :likes, source: :user

	has_many :reviews
	has_one :product_detail, dependent: :destroy

end
