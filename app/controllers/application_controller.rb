class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :get_tags
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def after_sign_out_path_for(resource)
		'/users/sign_in'
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys:[:nickname, :avatar])
	end

	def get_tags
		@tags = Beeeer.tags_on(:tags)
	end
end
