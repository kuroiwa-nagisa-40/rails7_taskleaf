class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.recent
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.title}」を登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_path, notice: "タスク「#{@task.title}」を編集しました！"
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスク「#{@task.title}」を削除しました！", status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
