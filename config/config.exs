# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :poc_cade_esse_cep, PocCadeEsseCepWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bLV7h/LTqLpc78tNNDDB0r7BzWKnufA8Nfe8yRSxDMF4mc5EvVTpdxca8GyB+OO+",
  render_errors: [view: PocCadeEsseCepWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PocCadeEsseCep.PubSub,
  live_view: [signing_salt: "b4Il9TwJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
