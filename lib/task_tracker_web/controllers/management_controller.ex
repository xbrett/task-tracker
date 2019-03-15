defmodule TaskTrackerWeb.ManagementController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Managements
  alias TaskTracker.Users
  alias TaskTracker.Managements.Management

  def index(conn, _params) do
    managements = Managements.list_managements()
    users = Users.list_users()
    render(conn, "index.html", managements: managements, users: users)
  end

  def new(conn, _params) do
    changeset = Managements.change_management(%Management{})
    manager_id = Managements.get_manager(conn)
    assignable_underlings = Users.list_assignable_underlings(conn, manager_id)
    render(conn, "new.html", changeset: changeset, assignable_underlings: assignable_underlings)
  end

  def create(conn, %{"management" => management_params}) do
    case Managements.create_management(management_params) do
      {:ok, management} ->
        conn
        |> put_flash(:info, "Management created successfully.")
        |> redirect(to: "/managements")

      {:error, %Ecto.Changeset{} = changeset} ->
      manager_id = Managements.get_manager(conn)
      assignable_underlings = Users.list_assignable_underlings(conn, manager_id)
        render(conn, "new.html", changeset: changeset, assignable_underlings: assignable_underlings)
    end
  end

  def show(conn, %{"id" => id}) do
    management = Managements.get_management!(id)
    users = Users.list_users()
    render(conn, "show.html", management: management, users: users)
  end

  def edit(conn, %{"id" => id}) do
    management = Managements.get_management!(id)
    changeset = Managements.change_management(management)
    manager_id = Managements.get_manager(conn)
    assignable_underlings = Users.list_assignable_underlings(conn, manager_id)
    render(conn, "edit.html", management: management, changeset: changeset, assignable_underlings: assignable_underlings)
  end

  def update(conn, %{"id" => id, "management" => management_params}) do
    management = Managements.get_management!(id)

    case Managements.update_management(management, management_params) do
      {:ok, management} ->
        conn
        |> put_flash(:info, "Management updated successfully.")
        |> redirect(to: "/managements")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", management: management, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    management = Managements.get_management!(id)
    {:ok, _management} = Managements.delete_management(management)

    conn
    |> put_flash(:info, "Management deleted successfully.")
    |> redirect(to: "/managements")
  end
end
