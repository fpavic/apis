defmodule ApisWeb.FallbackController do
  use ApisWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ApisWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ApisWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
