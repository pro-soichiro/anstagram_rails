class LikesController < ApplicationController
  def create
    @post = Post.find(params[:id])
    current_user.likes_posts << @post

    respond_to do |format|
      format.turbo_stream { render 'toggle', status: :created }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    current_user.likes_posts.destroy(@post)

    respond_to do |format|
      format.turbo_stream { render 'toggle', status: :see_other }
    end
  end
end
