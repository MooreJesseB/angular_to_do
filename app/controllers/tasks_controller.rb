class TasksController < ApplicationController

  before_action :set_task, only: [:show, :update, :destroy]
  before_action :render_main_layout_if_format_html
  respond_to :json, :html

  def index
    respond_with (@tasks = Task.all)
  end

  def create 
    respond_with Task.create(task_params)
  end

  def show
    respond_with @task
  end

  def update
    respond_with @task.update(task_params)
  end

  def destroy
    respond_with @task.destroy
  end

  private
  def set_task
    @task = Task.find_by_id(params[:id])
  end

  def task_params
    params.require(:book).permit()
  end

  def render_main_layout_if_html
    #check the request format
    if request.format.symbol == :html
      render "layouts/application"
    end
  end
end
