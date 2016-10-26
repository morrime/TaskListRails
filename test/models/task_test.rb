require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "validations: name can't be blank" do
    task = Task.create(description: "yolo")
    assert_not task.valid?
    # assert task.errors.keys.include?(:name), "name is not in the errors hash"
  end

  test "validations: description can't be blank" do
    task = Task.create(name: "poodles")
    assert_not task.valid?
    # assert task.errors.keys.include?(:description), "description is not in the errors hash"
  end

  test "can create a new task" do
    task = Task.create(name: "poodles", description: "yolo")
    assert task.valid?
    assert
  end
end
