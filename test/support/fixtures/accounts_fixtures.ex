defmodule PhoenixHonuExample.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixHonuExample.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        username: "some username"
      })
      |> PhoenixHonuExample.Accounts.create_user()

    user
  end

  @doc """
  Generate a user with avatar.
  """
  def user_with_avatar_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        "username" => "user123",
        "avatar" => %{"file" => "priv/static/images/phoenix.png"}
      })
      |> PhoenixHonuExample.Accounts.create_user_with_attachments()

    user
  end
end
