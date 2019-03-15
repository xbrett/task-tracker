defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string

    # All underling management records where I am the manager
    has_many :underlings_managements, TaskTracker.Managements.Management, foreign_key: :manager_id

    # All managemnt records where I am the underling
    has_one :manager_managements, TaskTracker.Managements.Management, foreign_key: :underling_id

    # All underlings I manage
    has_many :underlings, through: [:underlings_managements, :underling]

    # User who manages me
    has_one :manager, through: [:manager_managements, :manager]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :admin])
    |> validate_required([:email, :admin])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
