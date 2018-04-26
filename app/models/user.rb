class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
	has_many :beeeers
	has_many :likes, dependent: :destroy
	has_many :liked_beeeers, through: :likes, source: :beeeer

	validates :email, presence: true
	validates :nickname, presence: true

	has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }
	validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/png"]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	def already_liked?(beer)
		self.likes.exists?(beeeer_id: beer.id)
	end
end
