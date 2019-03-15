defmodule TaskTrackerWeb.TaskView do
  use TaskTrackerWeb, :view

def get_start_time(task) do
  "Task not started"
end
#   if task.timeblocks.start_time == nil do
#     "Task not started"
#   else
#     "{task.timeblocks.start_time}"
#   end
# end

def get_end_time(task) do
  "Task not started"
  # cond do
  #   task.timeblocks.start_time == nil && task.timeblocks.end_time == nil ->
  #     "Task not started"
  #   task.timeblocks.start_time != nil && task.timeblocks.end_time == nil ->
  #     "Task not ended"
  #   task.timeblocks.end_time != nil ->
  #     "{task.timeblocks.start_time}"
  # end
  end
end
