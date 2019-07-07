defmodule ApisWeb.ApiaryView do
  use ApisWeb, :view

  alias ApisWeb.ApiaryView

  def render("show.json", %{apiary: apiary}) do
    %{apiary: render_one(apiary, ApiaryView, "apiary.json")}
  end

  def render("apiary.json", %{apiary: apiary}) do
    %{id: apiary.id,
      lng: apiary.lng,
      lat: apiary.lat,
      name: apiary.name}
  end
end
