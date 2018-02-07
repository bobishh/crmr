defmodule Cryptomirror.Queries.Rates do
  import Ecto.Query, only: [from: 2]
  alias Cryptomirror.Repo
  alias Cryptomirror.Rate

  def by_creation(query) do
    from r in query, order_by: [desc: :rated_at], limit: 1
  end

  def recent() do
    Rate |> by_creation |> Repo.one! |> Map.from_struct |> Map.take([:btc, :bch, :eth])
  end
end
