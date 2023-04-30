defmodule PhoenixHonuExample.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias PhoenixHonuExample.Repo

  alias Honu.Attachments
  alias PhoenixHonuExample.Library.Book

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  def get_book_with_pages!(id) do
    Book
    |> preload(pages: :blob)
    |> Repo.get!(id)
  end

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  def create_book_with_attachments(attrs \\ %{}) do
    case Attachments.attachments_names(attrs, Book.attachments()) do
      [] ->
        create_book(attrs)

      attn ->
        Attachments.create_record_with_attachment(
          {%Book{}, &Book.changeset_with_attachments/2},
          attrs,
          attn
        )
        |> Repo.transaction()
        |> case do
          {:ok, %{record: book}} -> {:ok, book}
          {:error, :record, %Ecto.Changeset{} = changeset, _} -> {:error, changeset}
        end
    end
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  def update_book_with_attachments(%Book{} = book, attrs) do
    case Honu.Attachments.attachments_names(attrs, Book.attachments()) do
      [] ->
        update_book(book, attrs)

      attn ->
        Honu.Attachments.update_record_with_attachment(
          {book, &Book.changeset_with_attachments/2},
          attrs,
          attn
        )
        |> Repo.transaction()
        |> case do
          {:ok, %{record: book}} -> {:ok, book}
          {:error, :record, %Ecto.Changeset{} = changeset, _} -> {:error, changeset}
        end
    end
  end

  @doc """
  Deletes a book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  def delete_book_with_attachments(%Book{} = book) do
    Honu.Attachments.delete_record_with_attachment(book, Book.attachments())
    |> Repo.transaction()
    |> case do
      {:ok, %{record: book}} -> {:ok, book}
      {:error, :record, %Ecto.Changeset{} = changeset, _} -> {:error, changeset}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}

  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end
end
