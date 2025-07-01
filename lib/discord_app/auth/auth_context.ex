defmodule DiscordApp.Auth.AuthContext do

  alias DiscordApp.Auth.User
  alias DiscordApp.Auth.PasswordContext
  alias DiscordApp.Repo

  def register(params) do
    %User{}
    |> User.changeset(params)
    |> PasswordContext.hash_password
    |> Repo.insert
  end


end
