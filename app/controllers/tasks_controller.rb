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

end
