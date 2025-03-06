defmodule CheckobanWeb.PageController do
  use CheckobanWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  %Oban.Config{
    dispatch_cooldown: 5,
    engine: Oban.Engines.Basic,
    get_dynamic_repo: nil,
    insert_trigger: true,
    log: false,
    name: Oban,
    node: "OnlyDeans-MacBook-Pro",
    notifier: {Oban.Notifiers.Postgres, []},
    peer: {Oban.Peers.Database, []},
    plugins: [],
    prefix: "public",
    queues: [default: [limit: 10]],
    repo: Checkoban.Repo,
    shutdown_grace_period: 15000,
    stage_interval: 1000,
    testing: :disabled
  }
end
