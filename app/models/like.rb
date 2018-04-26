class Like < ActiveRecord::Base
	belongs_to :beeeer
	belongs_to :user

	validates_uniqueness_of :beeeer_id, scope: :user_id
end
