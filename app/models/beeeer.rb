class Beeeer < ActiveRecord::Base
	has_one :product_detail, dependent: :destroy
end
