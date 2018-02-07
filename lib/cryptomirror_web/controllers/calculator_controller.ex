defmodule CryptomirrorWeb.CalculatorController do
  use CryptomirrorWeb, :controller
  alias Cryptomirror.Converter
  use Params

  defparams calculate_changeset %{
    sum!: :float,
    currency!: :string,
    timestamp: :integer
  }

  def show(conn, params) do
    changeset = calculate_changeset(params)
    if changeset.valid? do
      data = Params.data(changeset)
      case Converter.calculate(data.sum, data.currency, data.timestamp) do
        {:ok, value} ->
          render conn, "show.html", %{result: value, currency: String.upcase(data.currency), sum: data.sum}
        {:error, err} ->
          render conn, "error.html"
      end
    else
      render conn, "error.html"
    end
  end
end
