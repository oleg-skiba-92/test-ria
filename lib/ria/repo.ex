defmodule Ria.Repo do
  use Ecto.Repo,
    otp_app: :ria,
    adapter: Ecto.Adapters.Postgres
end
