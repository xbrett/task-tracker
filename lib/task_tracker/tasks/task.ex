defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :time, :integer
    field :title, :string
    belongs_to :creator, TaskTracker.Users.User
    belongs_to :assignee, TaskTracker.Users.User

    has_many :timeblock, TaskTracker.Timeblocks.Timeblock

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :time, :completed, :creator_id, :assignee_id])
    |> validate_required([:title, :description, :completed, :creator_id, :assignee_id])
  end
end
