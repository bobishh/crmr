defmodule Cryptomirror.RateBuilderTest do
  use ExUnit.Case
  alias Cryptomirror.Rate
  alias Cryptomirror.RateBuilder
  import Mock

  test ".call returns Rate struct" do
    time = DateTime.utc_now()
    dumb_rate = 1.4242

    with_mock DateTime, [utc_now: fn -> time end] do
      expected  = %Rate{ btc: dumb_rate,
                         bch: dumb_rate,
                         eth: dumb_rate,
                         rated_at: time }
      assert RateBuilder.call(%{"BTC" => dumb_rate, "BCH" => dumb_rate, "ETH" => dumb_rate}) == expected
    end
  end
end
