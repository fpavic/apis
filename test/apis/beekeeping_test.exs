defmodule Apis.BeekeepingTest do
  use Apis.DataCase

  alias Apis.Beekeeping
  alias Apis.Beekeeping.Apiary

  describe "create apiary" do
    @tag :integration
    test "should succeed with valid data" do
      {:ok, user} = fixture(:user)

      assert {:ok, %Apiary{} = apiary} = Beekeeping.create_apiary(user, build(:apiary))
      assert apiary.name == "apiaryname"
      assert apiary.user_id == user.id
      assert apiary.lng_lat_point == %Geo.Point{
        coordinates: {19.8846, 44.3573},
        properties: %{},
        srid: 4326
      }
    end

    @tag :integration
    test "should fail with empty data and return changeset" do
      {:ok, user} = fixture(:user)

      assert {:error, %Ecto.Changeset{} = changeset} = Beekeeping.create_apiary(
        user, build(:apiary, name: "")
      )
      assert "can't be blank" in errors_on(changeset).name
    end

    @tag :integration
    test "should fail if only one from the lng / lat pair provided and return changeset" do
      {:ok, user} = fixture(:user)

      assert {:error, %Ecto.Changeset{} = changeset} = Beekeeping.create_apiary(
        user, build(:apiary, lng: "")
      )
      assert "can't be blank" in errors_on(changeset).lng

      assert {:error, %Ecto.Changeset{} = changeset} = Beekeeping.create_apiary(
        user, build(:apiary, lat: "")
      )
      assert "can't be blank" in errors_on(changeset).lat
    end

    @tag :integration
    test "should succeed if both lng and lat are absent" do
      {:ok, user} = fixture(:user)

      assert {:ok, %Apiary{} = apiary} = Beekeeping.create_apiary(
        user, build(:apiary, lat: "", lng: "")
      )
      assert apiary.name == "apiaryname"
      assert apiary.user_id == user.id
      assert apiary.lng_lat_point == nil
    end
  end

  describe "list apiaries" do
    @tag :integration
    test "should list apiaries of the user" do
      {:ok, user1} = fixture(:user)
      {:ok, user2} = fixture(:user, email: "test2@test.com", username: "test2")

      {:ok, apiary1} = fixture(:apiary, user: user1)
      {:ok, apiary2} = fixture(:apiary, user: user2)

      id1 = apiary1.id
      id2 = apiary2.id

      assert [%Apiary{id: ^id1}] = Beekeeping.list_apiaries(user1)
      assert [%Apiary{id: ^id2}] = Beekeeping.list_apiaries(user2)
    end
  end
end
