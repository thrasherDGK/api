# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :peepchat,
  ecto_repos: [Peepchat.Repo]

# Configures the endpoint
config :peepchat, Peepchat.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sQHvqL6hjRxf6ButPYSOw+Ln+1KHoI1exj02k89pTPMS+WWvC4b3cplaN01wWyD6",
  render_errors: [view: Peepchat.ErrorView, accepts: ~w(json)],
  pubsub: [name: Peepchat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders,
  "json-api": Poison

config :plug, :mimes, %{
  "application/vnd.api+json" => ["json-api"]
}

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Peepchat",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET") || "miW6ao1PWAERbUjfrOaWPVqEkm7ow3kuqDSAd3FoJbLFcM8fjEvm7k16YQkN4yYo",
  serializer: Peepchat.GuardianSerializer
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
