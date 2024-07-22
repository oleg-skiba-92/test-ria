defmodule Ria.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RiaWeb.Telemetry,
      Ria.Repo,
      {DNSCluster, query: Application.get_env(:ria, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ria.PubSub},
      # Start a worker by calling: Ria.Worker.start_link(arg)
      # {Ria.Worker, arg},
      # Start to serve requests, typically the last entry
      RiaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ria.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RiaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
