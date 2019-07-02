defmodule ApisWeb.UserControllerTest do
  use ApisWeb.ConnCase

  setup %{conn: build_conn} do
    {:ok, conn: put_req_header(build_conn, "accept", "application/json")}
  end

  describe "register user" do
    @tag :web
    test "should create and return user when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: build(:user)
      json = json_response(conn, 201)["user"]
      token = json["token"]
      id = json["id"]

      assert json == %{
        "id" => id,
        "email" => "test@test.com",
        "token" => token,
        "username" => "testname"
      }

      refute token == ""
    end

    @tag :web
    test "should not create user but render errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: build(:user, username: "")

      assert json_response(conn, 422)["errors"] == %{
        "username" => [
          "can't be blank"
        ]
      }
    end

    @tag :web
    test "should not create user but render errors when username has been taken", %{conn: conn} do
      {:ok, _user} = fixture(:user)
      conn = post conn, user_path(conn, :create), user: build(:user, email: "test2@test.com")

      assert json_response(conn, 422)["errors"] == %{
        "username" => [
          "has already been taken"
        ]
      }
    end

		@tag :web
		test "should not create user but render errors when invalid email format", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: build(:user, email: "test@")

      assert json_response(conn, 422)["errors"] == %{
        "email" => [
          "has invalid format"
        ]
      }
		end
  end
end
