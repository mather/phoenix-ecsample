defmodule Ecsample.SignupController do
  use Ecsample.Web, :controller
  alias Ecsample.User

  def new(conn, _) do
     user = User.changeset(%User{})
     render conn, "new.html", user: user
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case User.create(changeset, Ecsample.Repo) do
      {:ok, created_user} ->
        conn
        |> put_session(:current_user, created_user.id)
        |> put_flash(:info, "Your account has been created")
        |> redirect(to: "/")
      {:error, changeset} ->
        render conn, "new.html", user: changeset
    end
  end
end
