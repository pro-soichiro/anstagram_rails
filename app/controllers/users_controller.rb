class UsersController < ApplicationController
  before_action :auth_admin, only: :destroy

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
  end

  def edit
    @form_user = Form::User.new(user: User.find(params[:id]))
  end

  def update
    @form_user = Form::User.new(user_params, user: User.find(params[:id]))

    # FIXME: バリデーションに失敗した際に部署のチェックが消える
    if @form_user.save
      redirect_to @form_user, notice: 'プロフィールを更新しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path, status: :see_other
  end

  private
    def user_params
      params
        .require(:user)
        .permit(Form::User::USER_ATTR,
          departments: []
        )
    end
end
