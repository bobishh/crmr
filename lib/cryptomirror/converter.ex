defmodule Cryptomirror.Converter do
  import Ecto.Query, only: [from: 2]
  alias Cryptomirror.Repo
  alias Cryptomirror.Rate

  def calculate(sum, currency, timestamp) do
    time = case timestamp do
             nil -> DateTime.utc_now()
             int -> DateTime.from_unix!(int, :seconds)
           end
    Repo.one(query(time)) |> process_rate(sum, currency)
  end

  def process_rate(rate, sum, currency) do
    case rate do
      nil -> { :error, "No rate found" }
      found ->
        rate = Map.from_struct(rate)
        value = Float.ceil(sum / rate[String.to_atom(currency)], 2)
        { :ok, value }
    end
  end

  def query(time) do
    from u in Rate,
      where: u.rated_at < ^time, # find closest, need better query
      order_by: [desc: :rated_at],
      limit: 1
  end
end
