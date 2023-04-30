defmodule PhoenixHonuExample.Repo.Migrations.CreateBookAttachments do
  use Ecto.Migration
  require Honu.Migration

  def change do
    Honu.Migration.create_attachments_table(PhoenixHonuExample.Library.Book)

    alter table("honu_book_attachments") do
      add :page_number, :integer
    end

    create unique_index("honu_book_attachments", [:record_id, :page_number])
  end
end
