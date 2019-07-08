defmodule Apis.Beekeeping do
  import Ecto.Query, warn: false

  alias Apis.Repo

  alias Apis.Accounts.User
  alias Apis.Beekeeping.Apiary

  def create_apiary(%User{} = user, attrs \\ %{}) do
    %Apiary{}
    |> Apiary.changeset(attrs)
    |> put_user(user)
    |> Repo.insert()
  end

  def list_apiaries(%User{} = user) do
    Apiary
    |> user_apiaries_query(user)
    |> Repo.all 
  end

  defp put_user(changeset, user) do
    Ecto.Changeset.put_assoc(changeset, :user, user)
  end

  defp user_apiaries_query(query, user) do
    from a in query,
      where: a.user_id == ^user.id
  end
end
