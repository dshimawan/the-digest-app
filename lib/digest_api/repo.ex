defmodule DigestApi.Repo do
  use Ecto.Repo,
    otp_app: :digest_api,
    adapter: Ecto.Adapters.Postgres
end
