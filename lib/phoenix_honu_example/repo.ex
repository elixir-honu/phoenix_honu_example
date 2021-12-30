defmodule PhoenixHonuExample.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_honu_example,
    adapter: Ecto.Adapters.Postgres
end
