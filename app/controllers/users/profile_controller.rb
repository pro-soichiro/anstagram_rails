class Users::ProfileController < ApplicationController
  def edit
    @form_user = Form::User.new(user: User.find(params[:user_id]))
  end

  def update
    @form_user = Form::User.new(user_profile_params, user: User.find(params[:user_id]))

    if @form_user.save
      redirect_to @form_user, notice: 'プロフィールを更新しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_profile_params
    params
      .require(:user)
      .permit(Form::User::USER_ATTR,
              departments: [])
  end
end
