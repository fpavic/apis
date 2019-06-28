defmodule ApisWeb.UserView do
  use ApisWeb, :view

  alias ApisWeb.UserView

  def render("show.json", %{user: user, jwt: jwt}) do
    %{user: render_one(user, UserView, "user.json") |> Map.merge(%{token: jwt})}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      username: user.username}
  end
end
