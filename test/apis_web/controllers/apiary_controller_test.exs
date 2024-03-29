defmodule ApisWeb.ApiaryControllerTest do
  use ApisWeb.ConnCase

  setup %{conn: build_conn} do
    {:ok, conn: put_req_header(build_conn, "accept", "application/json")}
  end

  describe "list apiaries" do
    @tag :web
    test "should list apiaries that belong to user", %{conn: conn} do
      {:ok, user} = fixture(:user)
      {:ok, _apiary} = fixture(:apiary, user: user)

      conn = get authenticated_conn(conn, user), apiary_path(conn, :index)
      json = json_response(conn, 200)["apiaries"]
      id = hd(json)["id"]

      assert json == [
        %{
          "id" => id,
          "name" => "apiaryname",
          "lng" => 19.8846,
          "lat" => 44.3573
        }
      ]
    end

    @tag :web
    test "should not list apiaries when user unauthenticated", %{conn: conn} do
      conn = get conn, apiary_path(conn, :index)

      assert json_response(conn, 401)["error"] == "unauthenticated"
    end
  end

  describe "create apiary" do
    @tag :web
    test "should create and return apiary when data is valid", %{conn: conn} do
      conn = post authenticated_conn(conn), apiary_path(conn, :create), apiary: build(:apiary)
      json = json_response(conn, 201)["apiary"]
      id = json["id"]

      assert json == %{
        "id" => id,
        "name" => "apiaryname",
        "lng" => 19.8846,
        "lat" => 44.3573
      }
    end

    @tag :web
    test "should create and return apiary when lat and lng are not present", %{conn: conn} do
      conn = post authenticated_conn(conn), apiary_path(conn, :create), apiary: build(:apiary, lng: "", lat: "")
      json = json_response(conn, 201)["apiary"]
      id = json["id"]

      assert json == %{
        "id" => id,
        "name" => "apiaryname",
        "lng" => nil,
        "lat" => nil
      }
    end

    @tag :web
    test "should not create apiary but render errors when name is not present", %{conn: conn} do
      conn = post authenticated_conn(conn), apiary_path(conn, :create), apiary: build(:apiary, name: "")

      assert json_response(conn, 422)["errors"] == %{
        "name" => [
          "can't be blank"
        ]
      }
    end

    @tag :web
    test "should not create apiary but render errors when lng present and lat is not present", %{conn: conn} do
      conn = post authenticated_conn(conn), apiary_path(conn, :create), apiary: build(:apiary, lat: "")

      assert json_response(conn, 422)["errors"] == %{
        "lat" => [
          "can't be blank"
        ]
      }
    end

    @tag :web
    test "should not create apiary but render errors when lat present and lng is not present", %{conn: conn} do
      conn = post authenticated_conn(conn), apiary_path(conn, :create), apiary: build(:apiary, lng: "")

      assert json_response(conn, 422)["errors"] == %{
        "lng" => [
          "can't be blank"
        ]
      }
    end

    @tag :web
    test "should not create apiary when user unauthenticated", %{conn: conn} do
      conn = post conn, apiary_path(conn, :create), apiary: build(:apiary)

      assert json_response(conn, 401)["error"] == "unauthenticated"
    end
  end
end
