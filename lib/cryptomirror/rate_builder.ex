defmodule Cryptomirror.RateBuilder do
  alias Cryptomirror.Rate

  def call(data) do
    time = DateTime.utc_now()
    process_data(data, time)
  end

  defp process_data(data, time) do
    %Rate{ btc: Map.get(data, "BTC"),
           bch: Map.get(data, "BCH"),
           eth: Map.get(data, "ETH"),
           rated_at: time }
  end
end
