defmodule Cryptomirror.FetcherTest do
  use ExUnit.Case, async: true
  alias Cryptomirror.Fetcher
  import Mock

  test ".call returns hash map if response is ok" do
    with_mock HTTPoison, [get: fn(_url) ->
                           { :ok,  %HTTPoison.Response{body: "{\"BTC\":0.0001493,\"ETH\":0.001537,\"BCH\":0.001186}"} }
                         end] do

      { :ok, res } = Fetcher.call

      assert Map.get(res, "BTC") == 0.0001493
    end
  end

  test ".call returns nil in case of net error" do
    with_mock HTTPoison, [get: fn(_url) ->
                           { :error,  %HTTPoison.Error{id: nil, reason: :closed} }
                         end] do

      { result, _ } = Fetcher.call

      assert result == :error
    end
  end
end
