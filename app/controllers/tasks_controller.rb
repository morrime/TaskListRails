class TasksController < ApplicationController
def index
  @tasks = Task.all
end


def new
  @task = Task.new
end

def show
    @task = Task.find(params[:id])
end

def edit
  @task = Task.find(params[:id])
end

def update
  @task = Task.find(params[:id])
  if @task.update(task_params)
    # SUCCESS
    redirect_to tasks_path
  else
    # NOPE, NO SUCCESS
    render :edit
  end
end

def create
  @task = Task.new(task_params)
  if @task.save
    # SAVED SUCCESSFULLY
    redirect_to tasks_path
  else
    # DID NOT SAVE
    render :new
  end
end

private

def task_params
  params.require(:task).permit(:name, :description, :complete, :completion_date)
end


end
