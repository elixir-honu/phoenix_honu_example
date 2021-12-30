defmodule PhoenixHonuExample.Repo.Migrations.CreateUserAttachments do
  use Ecto.Migration
  require Honu.Migration

  def change do
    Honu.Migration.create_attachments_table(PhoenixHonuExample.Accounts.User)
  end
end
