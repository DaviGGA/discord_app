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
    Repo.get_by(User, email: params["email"])
    |> found_user_by_email
    |> password_valid(params["password"])
    |> sign_token
  end

  defp found_user_by_email(%User{} = user), do: user
  defp found_user_by_email(nil), do: {:error, :login_invalid}

  defp password_valid(%User{} =  user, params_password) do
    password_valid? = PasswordContext.verify_password(user, params_password)
    case password_valid? do
      true -> user
      false -> {:error, :login_invalid}
    end
  end
  defp password_valid({:error, reason}, _), do:  {:error, reason}

  defp sign_token(%User{} = user), do:
    TokenContext.generate_and_sign(%{"id" => user.id})

  defp sign_token({:error, reason}), do: {:error, reason}

end
