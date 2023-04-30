defmodule PhoenixHonuExample.LibraryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixHonuExample.Library` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> PhoenixHonuExample.Library.create_book()

    book
  end
end
