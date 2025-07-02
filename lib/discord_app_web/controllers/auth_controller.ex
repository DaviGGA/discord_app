defmodule DiscordAppWeb.AuthController do
  use DiscordAppWeb, :controller
  alias DiscordApp.Auth.AuthContext
  alias DiscordApp.Auth.User

  action_fallback DiscordAppWeb.FallbackController

  def register(conn, _params) do
    with {:ok, %User{} = user} <- AuthContext.register(conn.body_params) do
      conn
      |> put_status(:created)
      |> json(%{
        message: "User successfully created",
        data: user
      })
    end
  end

  def login(conn, _params) do
    with {:ok, token, _} <- AuthContext.login(conn.body_params) do
      conn
      |> put_status(200)
      |> json(%{
        message: "TODO",
        data: token
      })
    end
  end
end
