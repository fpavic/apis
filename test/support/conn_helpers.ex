defmodule ApisWeb.ConnHelpers do
  import Plug.Conn
  import Apis.Fixture

  alias ApisWeb.JWT

  def authenticated_conn(conn) do
    with {:ok, user} <- fixture(:user) do
      authenticated_conn(conn, user)
    end
  end

  def authenticated_conn(conn, user) do
    with {:ok, jwt} <- JWT.generate_jwt(user) do
      conn
      |> put_req_header("authorization", "Bearer " <> jwt)
    end
  end
end
