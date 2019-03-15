defmodule TaskTracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
