defmodule DiscordApp.Auth.PasswordContext do

  import Ecto.Changeset

  def hash_password(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(
        changeset,
        :password,
        Bcrypt.hash_pwd_salt(password)
      )
    end
  end

  def verify_password(user, password), do:
    Bcrypt.verify_pass(password, user.password)

end
