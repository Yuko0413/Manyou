class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      if user.admin?
        redirect_to admin_users_path, notice: 'ログインしました'
      else
        redirect_to root_path, notice: 'ログインしました'
      end
    else
      flash.now[:notice] = 'メールアドレスまたはパスワードに誤りがあります'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_path, notice: 'ログアウトしました'
  end
end
