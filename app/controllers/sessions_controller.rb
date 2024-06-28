class SessionsController < ApplicationController
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
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
