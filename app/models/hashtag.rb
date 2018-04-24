class Hashtag < ActiveRecord::Base
	has_many :beeeers, through: :hashtag_beeeers
	has_many :hashtag_beeeers
	accepts_nested_attributes_for :hashtag_beeeers
end
