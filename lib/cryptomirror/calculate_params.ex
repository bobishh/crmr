defmodule Cryptomirror.CalculateParams do
  use Params.Schema, %{sum!: :float, timestamp: :integer,
                       currency!: :string}
  import Ecto.Changeset, only: [cast: 3, validate_inclusion: 3, validate_required: 2]

  def child(ch, params) do
    cast(ch, params, ~w(sum timestamp currency))
    |> validate_inclusion(:timestamp, timestamp_from()..timestamp_to())
    |> validate_inclusion(:currency, ["btc","bch","eth"])
    |> validate_required([:sum, :currency])
  end

  defp timestamp_from do
    DateTime.from_naive!(~N[2017-12-12 13:26:08.003], "Etc/UTC") |>
    DateTime.to_unix(:seconds)
  end

  defp timestamp_to do
    DateTime.from_naive!(~N[2227-12-12 13:26:08.003], "Etc/UTC") |>
    DateTime.to_unix(:seconds)
  end
end
