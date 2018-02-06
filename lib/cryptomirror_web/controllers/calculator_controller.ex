defmodule CryptomirrorWeb.CalculatorController do
  use CryptomirrorWeb, :controller
  alias Cryptomirror.Converter

  def show(conn, params) do
    {sum, currency, time} = parse_params(params)
    result = Converter.calculate(sum, currency, time)
    render conn, "show.html", %{result: result, currency: String.upcase(currency), sum: sum}
  end

  defp parse_params(%{"sum" => sum, "currency" => currency, "timestamp" => timestamp}) do
    {parsed_sum, _ } = Float.parse(sum)
    {time_int, _} = Integer.parse(timestamp)
    {parsed_sum, currency, time_int}
  end
end
