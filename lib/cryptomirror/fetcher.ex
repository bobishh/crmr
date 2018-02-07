defmodule Cryptomirror.Fetcher do
  @query_string "https://min-api.cryptocompare.com/data/price?fsym=USD&tsyms=BTC,ETH,BCH"

  def call do
    case HTTPoison.get(@query_string) do
      { :ok, resp } -> { :ok, process_response(resp) }
      anything -> anything
    end
  end

  defp process_response(%HTTPoison.Response{body: body}) do
    Poison.decode!(body)
  end
end
