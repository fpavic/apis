defmodule Apis.Auth do
  @moduledoc """
  Authentication helper functions.
  """

  alias Apis.Accounts.User
  alias Apis.Accounts

  def authenticate(email, password) do
    with {:ok, user} <- user_by_email(email) do
      check_password(user, password)
    end
  end

  def hash_password(password), do: Bcrypt.hash_pwd_salt(password)
  def validate_password(password, hash), do: Bcrypt.check_pass(password, hash)

  defp user_by_email(email) do
    case Accounts.user_by_email(email) do
      nil -> {:error, :unauthenticated}
      user -> {:ok, user}
    end
  end

  defp check_password(%User{password_hash: password_hash} =  user, password) do
    case validate_password(password, password_hash) do
      true -> {:ok, user}
      _ -> {:error, :unauthenticated}
    end
  end
end
