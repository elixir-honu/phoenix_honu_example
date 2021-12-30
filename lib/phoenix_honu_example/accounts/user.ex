defmodule PhoenixHonuExample.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixHonuExample.Attachments.UserAttachment
  alias Honu.Attachments.Attachment

  schema "users" do
    field :username, :string

    has_one :avatar, UserAttachment,
      foreign_key: :record_id,
      where: [name: "avatar"]

    timestamps()
  end

  def attachments do
    [:avatar]
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end

  def changeset_with_attachments(user, attrs) do
    user
    |> changeset(attrs)
    |> Attachment.attachments_changeset(attrs, [{:avatar, &UserAttachment.changeset/2}])
  end
end
