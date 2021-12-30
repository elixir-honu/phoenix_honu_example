# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixHonuExample.Repo.insert!(%PhoenixHonuExample.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


{:ok, _user} = PhoenixHonuExample.Accounts.create_user_with_attachments(%{
  "username" => "user123",
  "avatar" => %{"file" => "priv/static/images/phoenix.png"}
})
