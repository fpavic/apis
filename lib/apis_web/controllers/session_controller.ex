defmodule ApisWeb.SessionController do
  use ApisWeb, :controller 

  action_fallback ApisWeb.FallbackController

  alias Apis.Accounts.User
  alias Apis.{Accounts, Auth}

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:ok, %User{} = user} <- Auth.authenticate(email, password),
         {:ok, jwt} <- generate_jwt(user) do
      conn
      |> put_status(:created)
      |> put_view(ApisWeb.UserView)
      |> render("show.json", user: user, jwt: jwt)
    end
  end
end
