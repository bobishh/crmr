defmodule CryptomirrorWeb.PageController do
  use CryptomirrorWeb, :controller
  alias Cryptomirror.Repo
  alias Cryptomirror.Queries
  alias Cryptomirror.Rate

  def index(conn, _params) do
    rate = Rate |> Queries.Rates.by_creation |> Repo.one
    render conn, "index.html", %{rate: rate}
  end
end
