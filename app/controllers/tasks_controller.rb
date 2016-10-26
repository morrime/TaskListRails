class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :complete]

  def index
    tasks = Task.all.where(user_id: session[:user_id])
    @tasks = tasks
  end

  def new
    @task = Task.new
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      if @task.complete == false
        @task.completion_date = nil
        @task.save
      else
        @task.completion_date = Date.current
        @task.save
      end
      # SUCCESS
      redirect_to tasks_path
    else
      # NOPE, NO SUCCESS
      render :edit
    end
  end

  def create
    if (@task = Task.create(task_params))
      @task.user_id = session[:user_id]
      @task.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end


  # def create
  #   @task = Task.new(task_params)
  #   if @task.save
  #     # SAVED SUCCESSFULLY
  #     redirect_to task_path(@task)
  #   else
  #     # DID NOT SAVE
  #     render :new
  #   end
  # end

  def destroy
    @task = Task.find(params[:id]).destroy
    redirect_to tasks_path
  end

  def complete

    if @task.complete == nil || @task.complete == false
      @task.update(complete: true)
      @task.update(completion_date: Date.today)
      redirect_to task_path
    else
      # @task.update(completion_date: nil)
      redirect_to task_path
    end

  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :complete, :user_id)
  end


end
