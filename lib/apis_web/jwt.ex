defmodule ApisWeb.JWT do
  @moduledoc """
  JWT helper functions, with Guardian
  """

  def generate_jwt(resource) do
    case Guardian.encode_and_sign(Apis.Guardian, resource) do
      {:ok, jwt, _full_claims} -> {:ok, jwt}
    end
  end
end
