defmodule ApisWeb.SetUser do
  import Plug.Conn

  alias Apis.Accounts.User

  def init(params), do: params

  def call(conn, _params) do
    case Guardian.Plug.current_resource(conn) do
      %User{} = user ->
        assign(conn, :current_user, user)
      _ ->
        assign(conn, :current_user, nil)
    end
  end
end
