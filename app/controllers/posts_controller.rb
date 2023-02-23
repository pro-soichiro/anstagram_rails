class PostsController < ApplicationController
  def index
    @posts = Post.eager_load(:user).order(created_at: :desc)
  end

  # TODO: モーダルにする
  def show
    @post = Post.eager_load(:likes_users).find(params[:id])
  end
end
