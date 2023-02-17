class UsersDepartmentsController < ApplicationController
  def edit
    @department = Department.find(params[:department_id])
  end

  def update
    @department = Department.find(params[:id])
    users = User.where(id: params[:department][:user_ids])
    @department.users = users

    redirect_to department_path(@department)
  end

  def destroy
    @department = Department.find(params[:department_id])
    @department.users.destroy(params[:user_id])

    redirect_to department_path(@department), status: :see_other
  end
end
