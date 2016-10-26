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
  @task = Task.new(task_params)
  if @task.save
    # SAVED SUCCESSFULLY
    redirect_to tasks_path
  else
    # DID NOT SAVE
    render :new
  end
end

def destroy
  Task.find(params[:id]).destroy
  redirect_to tasks_path
end

def complete
  @task = Task.find(params[:id])
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
  params.require(:task).permit(:name, :description, :complete)
end


end
