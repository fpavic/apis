defmodule Apis.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Apis.Auth

  @email_regex ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]+$/

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Auth.hash_password(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
