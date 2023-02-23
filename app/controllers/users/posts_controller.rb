class Users::PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash.now.notice = '投稿しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash.now.notice = '投稿を削除しました。'
  end

  private
    def post_params
      params.require(:post).permit(:caption)
    end
end
