defmodule DiscordApp.Auth.AuthContext do

  alias DiscordApp.Auth.User
  alias DiscordApp.Auth.PasswordContext
  alias DiscordApp.Auth.TokenContext
  alias DiscordApp.Repo

  def register(params) do
    %User{}
    |> User.changeset(params)
    |> PasswordContext.hash_password
    |> Repo.insert
  end

  def login(params) do
    with {:ok, user} <- get_user_by_email(params["email"]),
    {:ok, _} <- PasswordContext.verify_password(user, params["password"]) do
      TokenContext.generate_and_sign(%{"user_id" => user.id})
    end
  end

  defp get_user_by_email(email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, "Invalid email or password"}
    end
  end

  def me(user_id), do: Repo.get(User, user_id)

end
