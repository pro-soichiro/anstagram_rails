class UsersDepartmentsController < ApplicationController
  before_action :auth_admin

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    users = User.where(id: params[:department][:user_ids])
    @department.users = users

    redirect_to department_path(@department), notice: '部署のメンバーを更新しました！'
  end

  def destroy
    @department = Department.find(params[:id])
    @department.users.destroy(params[:user_id])

    redirect_to department_path(@department), status: :see_other, notice: '部署のメンバーを削除しました。'
  end
end
