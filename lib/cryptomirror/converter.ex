defmodule Cryptomirror.Converter do
  import Ecto.Query, only: [from: 2]
  alias Cryptomirror.Repo
  alias Cryptomirror.Rate

  def calculate(sum, currency, timestamp) do
    time = case timestamp do
             nil -> DateTime.utc_now()
             int -> parse_time(int)
           end
    Repo.one(query(time)) |> process_rate(sum, currency)
  end

  defp parse_time(timestamp) do
    case DateTime.from_unix(timestamp, :seconds) do
      {:ok, res} -> res
      _ -> DateTime.utc_now()
    end
  end

  defp process_rate(rate, sum, currency) do
    case rate do
      nil -> { :error, "No rate found" }
      found -> { :ok, rate_value(found, sum, currency) }
    end
  end

  defp rate_value(found, sum, currency) do
    rate = Map.from_struct(found)
    Float.ceil(sum / rate[String.to_atom(currency)], 2)
  end

  defp query(time) do
    from u in Rate,
      where: u.rated_at < ^time, # find closest, need better query
      order_by: [desc: :rated_at],
      limit: 1
  end
end
