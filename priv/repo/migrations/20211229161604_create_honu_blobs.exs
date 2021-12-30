defmodule PhoenixHonuExample.Repo.Migrations.CreateHonuBlobs do
  use Ecto.Migration
  require Honu.Migration

  def change do
    Honu.Migration.create_blobs_table()
  end
end
