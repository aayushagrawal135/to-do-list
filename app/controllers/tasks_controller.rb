class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: e.message
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save!
    redirect_to({ action: "show", id: @task.id })
  rescue ActiveRecord::RecordInvalid => e
    render json: e.message
  end

  def edit
    @task  = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: e.message
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(task_params)
    redirect_to({ action: "show", id: @task.id })
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to(root_path)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
