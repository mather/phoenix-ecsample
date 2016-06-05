defmodule Ecsample.SessionController do
  use Ecsample.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case Ecsample.Session.create(session_params, Ecsample.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Wrong email or password")
        |> render "new.html", session: changeset
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: "/")
  end
end
