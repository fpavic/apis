defmodule ApisWeb.ApiaryController do
  use ApisWeb, :controller

  action_fallback ApisWeb.FallbackController

  alias Apis.Beekeeping.Apiary
  alias Apis.Beekeeping

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_user) do
    apiaries = Beekeeping.list_apiaries(current_user)

    render(conn, "index.json", apiaries: apiaries)
  end

  def create(conn, %{"apiary" => apiary_params}, current_user) do
    with {:ok, %Apiary{} = apiary} <- Beekeeping.create_apiary(current_user, apiary_params) do
      conn
      |> put_status(:created)
      |> render("show.json", apiary: apiary)
    end
  end
end
