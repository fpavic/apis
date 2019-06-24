defmodule ApisWeb.UserController do
  use ApisWeb, :controller

  action_fallback ApisWeb.FallbackController

  alias Apis.Accounts.User
  alias Apis.Accounts

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, jwt} <- generate_jwt(user) do
      conn
      |> put_status(:created)
      |> render("jwt.json", user: user, jwt: jwt)
    end
  end
end
