defmodule LeagueOfNoob.Repo do
  use Ecto.Repo,
    otp_app: :league_of_noob,
    adapter: Ecto.Adapters.Postgres
end
