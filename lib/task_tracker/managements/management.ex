defmodule TaskTracker.Managements.Management do
  use Ecto.Schema
  import Ecto.Changeset



  schema "managements" do
    belongs_to :manager, Tasktracker.Users.User
    belongs_to :underling, Tasktracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(management, attrs) do
    management
    |> cast(attrs, [:manager_id, :underling_id])
    |> validate_required([:manager_id, :underling_id])
    |> unique_constraint(:no_duplicates, name: :no_dups, message: "They are already your underling")
  end
end
