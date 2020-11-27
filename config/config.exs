# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :digest_api,
  ecto_repos: [DigestApi.Repo]

# Configures the endpoint
config :digest_api, DigestApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "582FDjZni7j/X4Lfjrw0mBFG3v1HwKqtMGC7pgW5EK4LX8BvLRs8QJ8QabPfQDiC",
  render_errors: [view: DigestApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: DigestApi.PubSub,
  live_view: [signing_salt: "nEeVC35p"]

# Configures Pow
config :digest_api, :pow,
  user: DigestApi.Users.User,
  repo: DigestApi.Repo

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
