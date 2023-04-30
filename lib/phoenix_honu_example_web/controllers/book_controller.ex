defmodule PhoenixHonuExampleWeb.BookController do
  use PhoenixHonuExampleWeb, :controller

  alias PhoenixHonuExample.Library
  alias PhoenixHonuExample.Library.Book

  def index(conn, _params) do
    books = Library.list_books()
    render(conn, "index.html", books: books)
  end

  def new(conn, _params) do
    pages = [
      %PhoenixHonuExample.Attachments.BookAttachment{},
      %PhoenixHonuExample.Attachments.BookAttachment{}
    ]
    changeset = Library.change_book(%Book{pages: pages})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    case Library.create_book_with_attachments(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Library.get_book_with_pages!(id)
    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = Library.get_book_with_pages!(id)
    changeset = Library.change_book(book)
    render(conn, "edit.html", book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Library.get_book_with_pages!(id)

    case Library.update_book_with_attachments(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Library.get_book_with_pages!(id)
    {:ok, _book} = Library.delete_book_with_attachments(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: Routes.book_path(conn, :index))
  end
end
