class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @form_user = Form::User.new(user: User.find(params[:id]))
  end

  def update
    @form_user = Form::User.new(user_params, user: User.find(params[:id]))

    # FIXME: バリデーションに失敗した際に部署のチェックが消える
    if @form_user.save
      redirect_to @form_user
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
