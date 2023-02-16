class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def user_params
      params
        .require(:user)
        .permit(:last_name,
                :first_name,
                :last_name_kana,
                :first_name_kana,
                :email,
                :joined_on,
                :born_on,
                :nickname,
                :special_skill,
                :pastime,
                :motto,
                :motto_description,
                :career,
                :self_introduction)
    end
end
