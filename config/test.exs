import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :phoenix_honu_example, PhoenixHonuExample.Repo,
  hostname: "localhost",
  database: "phoenix_honu_example_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_honu_example, PhoenixHonuExampleWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "KMZD9JJ3ba5QQPIPs+KfXlDghygI3GyjjiQUtiECmF1RPDpqI2H1HpekQxFV/Sj4",
  server: false

# In test we don't send emails.
config :phoenix_honu_example, PhoenixHonuExample.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :honu, Honu.Storage,
  # TODO: Add in memory storage behaviour or clean directory after test
  storage: Honu.Storage.Disk,
  repo: PhoenixHonuExample.Repo,
  root_dir: "storage"

config :honu, HonuWeb.Storage,
  storage: HonuWeb.Storage.Disk,
  secret_key_base: "m+08I7aHnGEeTjfSX8s0reZ/1qmYcwVBgh2bgephQDBTy3yRUlQo8iO0IFkjq6Q1",
  repo: PhoenixHonuExample.Repo,
  service_urls_expire_in: 300
