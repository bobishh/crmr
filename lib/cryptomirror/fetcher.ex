defmodule Cryptomirror.Fetcher do
  @query_string "https://min-api.cryptocompare.com/data/price?fsym=USD&tsyms=BTC,ETH,BCH"

  def call do
    HTTPoison.get!(@query_string) |> Map.get(:body) |> Poison.decode!
  end
end
