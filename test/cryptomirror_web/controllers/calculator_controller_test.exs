defmodule CryptomirrorWeb.CalculatorControllerTest do
  use CryptomirrorWeb.ConnCase
  alias Cryptomirror.Repo
  alias Cryptomirror.Rate
  import Mock

  test "GET /show returns result value", %{conn: conn} do
    fake_rate = %Rate{ btc: 1.0, bch: 1.0,
                       eth: 1.0, rated_at: DateTime.utc_now() }

    with_mock Repo, [one: fn(_query) -> fake_rate end] do
      conn = get conn, "/api/calc", [sum: 1, currency: "btc"]
      assert json_response(conn, 200) == %{ "result" => 1.0 }
    end
  end

  test "GET /show renders error if no data at that timestamp", %{conn: conn} do
    with_mock Repo, [one: fn(_query) -> nil end] do
      conn = get conn, "/api/calc", [sum: 1, currency: "btc"]
      assert json_response(conn, 422) == %{ "error" => "No rate found" }
    end
  end

  test "GET /show renders error if wrong params", %{conn: conn} do
    conn = get conn, "/api/calc", [sum: 1]
    assert json_response(conn, 422) == %{ "error" => "Wrong params" }
  end
end
