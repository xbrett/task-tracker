defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Users

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    users = Users.list_users()
    render(conn, "index.html", tasks: tasks, users: users)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    assignables = Users.list_assignable_users(conn)
    render(conn, "new.html", changeset: changeset, assigned_to: false, assignables: assignables)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
      assignables = Users.list_assignable_users(conn)
        render(conn, "new.html", changeset: changeset, assignables: assignables)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    assigned_to = task.assignee_id
    created_by = task.creator_id
    users = Users.list_users
    render(conn, "show.html", task: task, assigned_to: assigned_to, created_by: created_by, users: users)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    assigned_to = task.assignee_id
    assignables = Users.list_assignable_users(conn)
    render(conn, "edit.html", task: task, changeset: changeset, assigned_to: assigned_to, assignables: assignables)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    assigned_to = task.assignee_id
    assignables = Users.list_assignable_users(conn)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, assigned_to: assigned_to, assignables: assignables)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: "/home")
  end
end
