defmodule Ecsample.Session do
  alias Ecsample.User

  def create(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> {:error, params}
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    Ecsample.Repo.get_by(User, id: id)
  end

  def logged_in?(conn) do
    !!Plug.Conn.get_session(conn, :current_user)
  end
end
