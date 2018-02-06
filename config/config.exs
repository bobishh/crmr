# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cryptomirror,
  ecto_repos: [Cryptomirror.Repo]

# Configures the endpoint
config :cryptomirror, CryptomirrorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BfF8rTiaio8Ev7n2duewCm8DiN4cVGr0Ne9mGhmFUCtgPhRVEUP366Ebhr62SQU1",
  render_errors: [view: CryptomirrorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cryptomirror.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
