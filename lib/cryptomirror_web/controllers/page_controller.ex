defmodule CryptomirrorWeb.PageController do
  use CryptomirrorWeb, :controller
  alias Cryptomirror.Repo
  alias Cryptomirror.Rate

  def index(conn, _params) do
    rate = Rate |> Rate.by_creation |> Repo.one
    render conn, "index.html", %{rate: rate}
  end
end
