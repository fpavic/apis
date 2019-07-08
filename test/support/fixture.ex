defmodule Apis.Fixture do
  import Apis.Factory

  def fixture(resource, attrs \\ [])
  def fixture(:user, attrs) do
    build(:user, attrs) |> Apis.Accounts.create_user()
  end

  def fixture(:apiary, user: user) do
    Apis.Beekeeping.create_apiary(user, build(:apiary))
  end
end
