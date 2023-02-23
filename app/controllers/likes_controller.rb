class LikesController < ApplicationController
  def create
    # debugger
    post = Post.find(params[:id])
    current_user.likes_posts << post
    @user = post.user

    # TODO: turboにしたい
    redirect_back fallback_location: @user
  end

  def destroy
    post = Post.find(params[:id])
    current_user.likes_posts.destroy(post)

    # TODO: turboにしたい
    redirect_to post.user, status: :see_other
  end
end
