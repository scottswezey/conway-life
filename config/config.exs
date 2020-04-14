# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :life, LifeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "e68HXEFfjbScRLiTrxg9cUbIVbqRuhuT4voe1tUGi7Xj723D8ONDS//4FEGg4moE",
  render_errors: [view: LifeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Life.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "v/xnF3yJ4eV3cPZ2EZHxCnapc0tjUupz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
