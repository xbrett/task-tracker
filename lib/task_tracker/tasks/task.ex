defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :time, :integer
    field :title, :string
    belongs_to :user, TaskTracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :time, :user_id])
    |> validate_required([:title, :description, :completed, :time, :user_id])
    |> validate_time_increment(:time)
  end

  def validate_time_increment(changeset, field, _options \\ []) do
    validate_change(changeset, field, fn _, time ->
      if (time < 0) do
        []
      end
      case(rem(time, 15)) do
       0 -> []
       _ -> [time: "15-minute increments only"]
      end
    end)
  end
end
