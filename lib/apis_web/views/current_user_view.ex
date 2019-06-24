defmodule ApisWeb.CurrentUserView do
  use ApisWeb, :view

  alias ApisWeb.CurrentUserView

  def render("show.json", %{current_user: user}) do
    %{data: render_one(user, CurrentUserView, "user.json")}
  end

  def render("user.json", %{current_user: user}) do
    %{id: user.id,
      email: user.email,
      username: user.username}
  end
end
