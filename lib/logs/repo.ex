defmodule Logs.Repo do
  use Ecto.Repo,
    otp_app: :logs,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 250
end
