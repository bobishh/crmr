defmodule Cryptomirror.Sync do
  use GenServer
  alias Cryptomirror.Fetcher
  alias Cryptomirror.RateBuilder
  alias Cryptomirror.Repo
# alias Cryptomirror.Endpoint
  alias Cryptomirror.Logger

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
      {:error, err } ->
        Logger.error(err)
    end
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1 * 30 * 1000) # Every 30 seconds
  end
end
