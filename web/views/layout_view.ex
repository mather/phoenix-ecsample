defmodule Ecsample.LayoutView do
  use Ecsample.Web, :view
  import Ecsample.Session, only: [current_user: 1, logged_in?: 1]
end
