defmodule Cryptomirror.Sync do
  use GenServer
  alias Cryptomirror.Fetcher
  alias CryptomirrorWeb.Endpoint
  alias Cryptomirror.RateBuilder
  alias Cryptomirror.Repo

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    request_and_process()
    schedule_work() # Reschedule once more
    {:noreply, state}
  end

  defp request_and_process do
    case Fetcher.call do
      {:ok, res} ->
        res |> RateBuilder.call |> Repo.insert!
        Endpoint.broadcast! "rates:live", "update", process_for_socket(res)
      {:error, err } ->
        IO.inspect err
    end
  end

  defp process_for_socket(res) do
    res |> Map.take(["BTC", "BCH", "ETH"]) |> downcase_keys
  end

  defp downcase_keys(map) do
    Map.keys(map) |> Enum.reduce(%{}, fn (key, acc) ->
      acc |> Map.put(String.downcase(key), Map.get(map, key))
    end)
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1 * 30 * 1000) # Every 30 seconds
  end
end
