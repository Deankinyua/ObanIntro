defmodule Checkoban.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CheckobanWeb.Telemetry,
      Checkoban.Repo,
      {DNSCluster, query: Application.get_env(:checkoban, :dns_cluster_query) || :ignore},
      # sets up Oban instances to run as children in the supervision trees
      {Oban, Application.fetch_env!(:checkoban, Oban)},
      {Phoenix.PubSub, name: Checkoban.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Checkoban.Finch},
      # Start a worker by calling: Checkoban.Worker.start_link(arg)
      # {Checkoban.Worker, arg},
      # Start to serve requests, typically the last entry
      CheckobanWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Checkoban.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CheckobanWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
