defmodule TaskTrackerWeb.PageController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Users
  alias TaskTracker.Managements

  def index(conn, _params) do
    if Plug.Conn.get_session(conn, :user_id) do
      redirect(conn, to: "/home")
    end
    render conn, "index.html"
  end

  def home(conn, _params) do
    if !Plug.Conn.get_session(conn, :user_id) do
      redirect(conn, to: "/index")
    end
    manager_id = Managements.get_manager(conn)
    IO.inspect(manager_id)
    user_tasks = Tasks.list_assigned_tasks(conn)
    users = Users.list_users()
    underlings = Managements.list_underlings(conn)
    underlings = Enum.map(underlings, fn(x) -> Tasks.list_underling_tasks(conn, x) end)
    render(conn, "home.html", user_tasks: user_tasks, users: users, manager_id: manager_id, underlings: underlings)
  end

end
