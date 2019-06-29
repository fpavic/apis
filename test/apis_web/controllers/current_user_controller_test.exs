defmodule ApisWeb.CurrentUserControllerTest do
  use ApisWeb.ConnCase

  setup %{conn: build_conn} do
    {:ok, conn: put_req_header(build_conn, "accept", "application/json")}
  end

  describe "get current user" do
    @tag :web
    test "should return user when authenticated", %{conn: conn} do
      conn = get authenticated_conn(conn), current_user_path(conn, :show)
      json = json_response(conn, 200)["user"]
      id = json["id"]

      assert json == %{
        "id" => id,
        "email" => "test@test.com",
        "username" => "testname"
      }
    end
  end
end
