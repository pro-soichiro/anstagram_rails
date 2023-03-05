class DepartmentsController < ApplicationController
  before_action :auth_admin, except: %i[index show]

  def index
    @departments = Department.all
  end

  def show
    @department = Department.find(params[:id])
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to @department, notice: '新しい部署を作成しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      redirect_to @department, notice: '部署の情報を更新しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    redirect_to departments_path, status: :see_other, notice: '部署を削除しました。'
  end

  private

  def department_params
    params
      .require(:department)
      .permit(:name,
              :description)
  end
end
