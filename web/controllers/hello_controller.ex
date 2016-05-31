defmodule Ecsample.HelloController do
  use Ecsample.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
