defmodule Apis.Repo do
  use Ecto.Repo,
    otp_app: :apis,
    adapter: Ecto.Adapters.Postgres
end
