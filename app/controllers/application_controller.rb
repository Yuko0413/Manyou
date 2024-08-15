class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale
  helper_method :current_user, :logged_in?
  before_action :login_required

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # def default_url_options(options = {})
  #   { locale: I18n.locale }.merge options
  # end

  def current_user
    if session[:user_id]
      begin
        @current_user ||= User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        session[:user_id] = nil
        redirect_to new_session_path, alert: "ログインが必要です"
      end
    end
  end

  def logged_in?  # 追加
    !current_user.nil?
  end

  def login_required
    redirect_to new_session_path, notice: "ログインしてください" unless current_user
  end

  def redirect_if_logged_in
    if logged_in?
      flash[:notice] = 'ログアウトしてください'
      redirect_to tasks_path
    end
  end
end


  #helper :all
#end
