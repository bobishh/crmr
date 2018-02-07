defmodule CryptomirrorWeb.RatesChannel do
  use CryptomirrorWeb, :channel
  alias Cryptomirror.Queries.Rates
  alias Cryptomirror.Rate
  alias Cryptomirror.Repo

  def join("rates:" <> room, _params, socket) do
    {:ok, socket |> assign(:room, room) }
  end

  def handle_in("get_rates", _params, socket) do
    push socket, "update", Rates.recent()
    {:reply, :ok, socket }
  end

  def id(_p), do: nil
end
