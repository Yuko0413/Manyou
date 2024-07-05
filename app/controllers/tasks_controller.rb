class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy]


  def index
    @tasks = current_user.tasks

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
      @tasks = @tasks.sorted_by_created_at
    end

    @tasks = @tasks.page(params[:page]).per(10)

    # デバッグ用のログ出力
    logger.debug "検索条件: #{params[:search].inspect}" if params[:search]
    logger.debug "ソート条件: sort=#{params[:sort]}, direction=#{params[:direction]}"
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status, { label_ids: [] })
  end

  def authorize_user
    if @task.user != current_user
      redirect_to tasks_path, notice: 'アクセス権限がありません'
    end
  end
end
