defmodule DiscordApp.Repo.Migrations.AddUniqueIndexEmail do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:email])
  end
end
