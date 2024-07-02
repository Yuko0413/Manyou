module Admin
  class UsersController < ApplicationController
    #layout 'admin'
    
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_admin

    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: 'ユーザを登録しました'  # 変更
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: 'ユーザを更新しました'
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: 'ユーザを削除しました'
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: 'You are not authorized to access this page.'
      end
    end
  end
end
