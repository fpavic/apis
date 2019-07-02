defmodule ApisWeb.SessionControllerTest do
  use ApisWeb.ConnCase

  setup %{conn: build_conn} do
    {:ok, conn: put_req_header(build_conn, "accept", "application/json")}
  end

  describe "authenticate user" do
    @tag :web
    test "should create session when data is valid", %{conn: conn} do
      {:ok, _user} = fixture(:user)

      conn = post conn, session_path(conn, :create), user: build(:user)

      json = json_response(conn, 201)["user"]
      id = json["id"]
      token = json["token"]

      assert json == %{
        "id" => id,
        "token" => token,
        "email" => "test@test.com",
        "username" => "testname"
      }
    end

    @tag :web
    test "should not create session but render errors when user not found", %{conn: conn} do
      conn = post conn, session_path(conn, :create), user: build(:user)

			assert json_response(conn, 422)["errors"] == %{
				"email or password" => [
					"is invalid"
				]
      }
    end

    @tag :web
    test "should not create session but render errors when password does not match", %{conn: conn} do
      {:ok, user} = fixture(:user)

      conn = post conn, session_path(conn, :create), user: build(:user, password: "invalid")

			assert json_response(conn, 422)["errors"] == %{
				"email or password" => [
					"is invalid"
				]
      }
    end
  end
end
