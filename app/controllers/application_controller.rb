class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale
  helper_method :current_user, :logged_in?

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def current_user  # 追加
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?  # 追加
    !current_user.nil?
  end
end
  #helper :all
#end
