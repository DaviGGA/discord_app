defmodule DiscordApp.Repo do
  use Ecto.Repo,
    otp_app: :discord_app,
    adapter: Ecto.Adapters.Postgres
end
