defmodule LiveSelectDebug.Repo do
  use Ecto.Repo,
    otp_app: :live_select_debug,
    adapter: Ecto.Adapters.Postgres
end
