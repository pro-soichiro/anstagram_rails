class PostsController < ApplicationController

  def index
    @posts = Post.eager_load(:user).order(created_at: :desc)
  end

  def show
    @post = Post.eager_load(:likes_users).find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to user_path(@user)
    else
      render "users/show", status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_path(@user), status: :see_other
  end

  private
    def post_params
      params.require(:post).permit(:caption)
    end
end
