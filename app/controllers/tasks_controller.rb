class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('flash.task.create_success')
    else
      render :new #, status: unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task, notice: t('flash.task.update_success')
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: t('flash.task.destroy_success')
  end



  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end
end


