defmodule ApisWeb.CurrentUserController do
  use ApisWeb, :controller

  def show(conn, _params) do
    user = conn.assigns.current_user
    render(conn, "show.json", current_user: user )
  end
end
