defmodule CryptomirrorWeb.CalculatorController do
  use CryptomirrorWeb, :controller
  alias Cryptomirror.Converter
  alias Cryptomirror.CalculateParams

  def show(conn, params) do
    changeset = CalculateParams.from(params, with: &CalculateParams.child/2)
    if changeset.valid? do
      data = Params.data(changeset)
      case Converter.calculate(data.sum, data.currency, data.timestamp) do
        {:ok, value} ->
          json conn, %{ result: value }
        {:error, err} ->
          conn |> put_status(422) |> json(%{ error: err })
      end
    else
      conn |> put_status(422) |> json(%{ error: "Wrong params" })
    end
  end
end
