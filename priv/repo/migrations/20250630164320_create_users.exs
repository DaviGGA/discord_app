defmodule DiscordApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, size: 50, null: false
      add :password, :string, null: false
      timestamps(type: :utc_datetime)
    end
  end
end
