defmodule Cryptomirror.Converter do
  import Ecto.Query, only: [from: 2]
  alias Cryptomirror.Repo
  alias Cryptomirror.Rate

  def calculate(sum, currency, timestamp) do
    time = case DateTime.from_unix(timestamp, :seconds) do
             {:ok, time} -> time
             _ -> DateTime.utc_now()
           end
    res = Map.from_struct(Repo.one(query(time)))
    Float.ceil(sum / res[String.to_atom(currency)], 2)
  end

  def query(time) do
    from u in Rate,
      where: u.rated_at < ^time,
      order_by: [desc: :rated_at],
      limit: 1
  end
end
