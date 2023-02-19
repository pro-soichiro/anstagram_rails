class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts_size = @user.posts.size
    @post = @user.posts.build
  end

  def new
    @form_user = Form::User.new
  end

  def create
    @form_user = Form::User.new(form_user_params)

    if @form_user.save
      redirect_to user_path(@form_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @form_user = Form::User.find(params[:id])
  end

  def update
    @form_user = Form::User.find(params[:id])

    if @form_user.update(form_user_params)
      redirect_to user_path(@form_user)
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
    def form_user_params
      params
        .require(:form_user)
        .permit(Form::User::USER_ATTR,
          departments: []
        )
    end

    # TODO: birthplaceは複数持てないようにしたが、配列としてパラメータに渡せるので、
    #       permit(:last_name, birthplaces: [ :prefecture, :detail ] )
    #       として、受け取れる
    #       Parameters: {
    #                     :form_user => {
    #                       "last_name"=>"something",
    #                       "birthplaces"=> [
    #                         "prefecture"=>"1",
    #                         "detail"=>"something"
    #                       ]
    #                     }
    #                   }
end
