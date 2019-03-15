defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :string, null: false
      add :time, :integer
      add :completed, :boolean, default: false, null: false
      add :creator_id, references(:users, on_delete: :nothing), null: false
      add :assignee_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tasks, [:creator_id])
    create index(:tasks, [:assignee_id])
  end
end
