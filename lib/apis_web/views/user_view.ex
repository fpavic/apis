defmodule ApisWeb.UserView do
  use ApisWeb, :view

  def render("jwt.json", %{user: user, jwt: jwt}) do
    %{id: user.id,
      email: user.email,
      username: user.username,
      jwt: jwt}
  end
end
