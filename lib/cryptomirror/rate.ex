defmodule Cryptomirror.Rate do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cryptomirror.Rate


  schema "rates" do
    field :bch, :float
    field :btc, :float
    field :eth, :float
    field :rated_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(%Rate{} = rate, attrs) do
    rate
    |> cast(attrs, [:btc, :bch, :eth, :rated_at])
    |> validate_required([:btc, :bch, :eth, :rated_at])
  end
end
