defmodule Checkoban.Repo do
  use Ecto.Repo,
    otp_app: :checkoban,
    adapter: Ecto.Adapters.Postgres
end
