defmodule LeagueOfNoob.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LeagueOfNoobWeb.Telemetry,
      LeagueOfNoob.Repo,
      {DNSCluster, query: Application.get_env(:league_of_noob, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LeagueOfNoob.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LeagueOfNoob.Finch},
      # Start a worker by calling: LeagueOfNoob.Worker.start_link(arg)
      # {LeagueOfNoob.Worker, arg},
      # Start to serve requests, typically the last entry
      LeagueOfNoobWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LeagueOfNoob.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LeagueOfNoobWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
