class UsersController < ApplicationController
  before_action :auth_admin, only: :destroy

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィール画像を更新しました！'
    else
      @user.avatar = nil
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end
end
