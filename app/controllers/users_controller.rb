class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :redirect_if_logged_in, only: [:new, :create]

  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "アカウントを登録しました"
    else
      Rails.logger.debug(@user.errors.full_messages)  # エラーメッセージのログ出力
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "アカウントを更新しました"
    else
      #Rails.logger.debug(@user.errors.full_messages)  # エラーメッセージのログ出力
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
