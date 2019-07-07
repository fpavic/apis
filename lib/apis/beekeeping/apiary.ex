defmodule Apis.Beekeeping.Apiary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "apiaries" do
    field :name, :string
    field :lng_lat_point, Geo.PostGIS.Geometry
    field :lng, :float, virtual: true
    field :lat, :float, virtual: true

    belongs_to :user, Apis.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(apiary, attrs) do
    apiary
    |> cast(attrs, [:name, :lng, :lat])
    |> validate_required([:name])
    |> put_coordinates()
  end

  defp put_coordinates(%Ecto.Changeset{valid?: true, changes: %{lng: lng, lat: lat}} = changeset) do
    geo = %Geo.Point{coordinates: {lng, lat}, srid: 4326}
    put_change(changeset, :lng_lat_point, geo)
  end
  defp put_coordinates(%Ecto.Changeset{changes: %{lng: _lng}} = changeset) do 
    validate_required(changeset, [:lat])
  end
  defp put_coordinates(%Ecto.Changeset{changes: %{lat: _lat}} = changeset) do 
    validate_required(changeset, [:lng])
  end
  defp put_coordinates(changeset), do: changeset
end
