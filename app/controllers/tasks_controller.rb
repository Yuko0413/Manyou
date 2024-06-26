class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.sorted_by_created_at

    if params[:sort_deadline_on]
      @tasks = @tasks.sorted_by_deadline
    elsif params[:sort_priority]
      @tasks = @tasks.sorted_by_priority
    end

    if params[:search]
      @tasks = @tasks.with_status(params[:search][:status])
                     .with_title(params[:search][:title])
    end

    @tasks = @tasks.page(params[:page]).per(10)

    # デバッグ用のログ出力
    logger.debug "検索条件: #{params[:search].inspect}" if params[:search]
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
    if @task.update(task_params)
      redirect_to @task, notice: t('flash.task.update_success')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('flash.task.destroy_success')
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status)
  end
end
