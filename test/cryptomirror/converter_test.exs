defmodule Cryptomirror.ConverterTest do
  use ExUnit.Case
  alias Cryptomirror.Converter
  alias Cryptomirror.Rate
  alias Cryptomirror.Repo
  import Mock

  test ".calculate converts sum to USD" do
    fake_rate = %Rate{ btc: 1.0, bch: 1.0,
                       eth: 1.0, rated_at: DateTime.utc_now() }

    with_mock Repo, [one: fn(_query) -> fake_rate end] do
      { status, result } = Converter.calculate(12.12, "btc", nil)
      assert result == 12.12
    end
  end

  test ".calculate returns nil if no rate found" do
    with_mock Repo, [one: fn(_query) -> nil end] do
      { status, _ } = Converter.calculate(12.12, "btc", nil)
      assert  status == :error
    end
  end
end
