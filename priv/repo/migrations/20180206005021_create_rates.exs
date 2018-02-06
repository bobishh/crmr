defmodule Cryptomirror.Repo.Migrations.CreateRates do
  use Ecto.Migration

  def change do
    create table(:rates) do
      add :btc, :float, null: false
      add :bch, :float, null: false
      add :eth, :float, null: false
      add :rated_at, :utc_datetime, null: false

      timestamps()
    end

  end
end
