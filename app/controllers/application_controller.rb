class ApplicationController < ActionController::Base
	before_action :set_locale
	
	def set_locale
		I18n.locale = :ru
	end
	
	protect_from_forgery with: :exception
	include SessionsHelper
end
