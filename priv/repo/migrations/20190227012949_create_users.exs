defmodule TaskTracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :admin, :boolean, default: false, null: false
      add :email, :string

      timestamps()
    end

  end
end
