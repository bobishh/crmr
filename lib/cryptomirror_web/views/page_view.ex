defmodule CryptomirrorWeb.PageView do
  use CryptomirrorWeb, :view

  def rates_list(rate) do
    "BTC: #{usd_price(rate.btc)},
     BCH: #{usd_price(rate.bch)},
     ETH: #{usd_price(rate.eth)}"
  end

  defp usd_price(rate) do
    "#{Float.ceil(1/rate)} $"
  end
end
