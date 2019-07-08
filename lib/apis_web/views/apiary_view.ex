defmodule ApisWeb.ApiaryView do
  use ApisWeb, :view

  alias ApisWeb.ApiaryView
  alias Apis.Beekeeping.Apiary

  def render("show.json", %{apiary: apiary}) do
    %{apiary: render_one(apiary, ApiaryView, "apiary.json")}
  end

  def render("index.json", %{apiaries: apiaries}) do
    %{apiaries: render_many(apiaries, ApiaryView, "apiary.json")}
  end

  def render("apiary.json", %{apiary: %Apiary{lng_lat_point: %Geo.Point{coordinates: {lng, lat}}} = apiary}) do
    %{id: apiary.id,
      lng: lng,
      lat: lat,
      name: apiary.name}
  end

  def render("apiary.json", %{apiary: apiary}) do
    %{id: apiary.id,
      lng: nil,
      lat: nil,
      name: apiary.name}
  end
end
