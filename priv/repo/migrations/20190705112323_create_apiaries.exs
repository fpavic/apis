defmodule Apis.Repo.Migrations.CreateApiaries do
  use Ecto.Migration

  def up do
    create table(:apiaries) do
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all, null: false)

      timestamps()
    end

    create index(:apiaries, [:user_id])

    execute "CREATE EXTENSION IF NOT EXISTS postgis"
    execute("SELECT AddGeometryColumn ('apiaries','lng_lat_point',4326,'POINT',2);")
  end

  def down do
    execute "DROP EXTENSION IF EXISTS postgis"

    drop table(:apiaries)
  end
end
