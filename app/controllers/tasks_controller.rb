class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy, :complete]

  def index
    @tasks = current_user.tasks.where.not(status: 'completed')

    # 検索条件の適用
    if params[:search]
      @tasks = @tasks.with_status(params[:search][:status])
                     .with_title(params[:search][:title])
                     .with_label(params[:search][:label])
    end

    # ソート条件が存在する場合は適用
    if params[:sort].present? && params[:direction].present?
      if params[:sort] == 'priority'
        @tasks = @tasks.order(priority: :desc, created_at: :desc)
      else
        @tasks = @tasks.order("#{params[:sort]} #{params[:direction]}")
      end
    else
      @tasks = @tasks.order(deadline_on: :asc)  # ここで終了期限の昇順にソート
    end

    @tasks = @tasks.page(params[:page]).per(10)
  end

  def new
    @task = Task.new
    @tasks = current_user.tasks.where.not(status: 'completed').page(params[:page]).per(10)
  end

  def complete
    @task.update(status: 'completed', completed_at: Time.current)
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully completed.' }
      format.json { head :no_content }
    end
  end

  def completed
    @completed_tasks = Task.where(status: 'completed').order(completed_at: :desc)
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to new_task_path, notice: t('flash.task.create_success')
    else
      @tasks = current_user.tasks.where.not(status: 'completed').page(params[:page]).per(10)  # ここでも完了したタスクを除外
      render :new #, status: unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('flash.task.update_success')
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
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status, { label_ids: [] })
  end

  def authorize_user
    redirect_to tasks_path, notice: 'アクセス権限がありません' unless @task.user == current_user
  end
end
