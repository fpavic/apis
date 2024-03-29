# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :apis,
  ecto_repos: [Apis.Repo]

# Configures the endpoint
config :apis, ApisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "c0U4wQAOct93u6WEpWwbHCMiUO9CWfOKIkz0vl3q5Fv1GOcaZinbHQ6ZXo63Yulu",
  render_errors: [view: ApisWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Apis.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :apis, Apis.Guardian,
  issuer: "apis",
  secret_key: "uItBk4CZfTxmM0pbD+bIJrL2U01Na7dBtdaR+o3D5638jYdS/WW4JvlTnmJoV9B/"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
