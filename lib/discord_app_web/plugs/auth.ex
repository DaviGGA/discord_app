defmodule DiscordAppWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias DiscordApp.Auth.TokenContext

  def init(default), do: default

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
    {:ok, claims} <- TokenContext.verify_and_validate(token) do
      assign(conn, :user_id, claims["user_id"])
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Token unauthorized"})
        |> halt()
    end
  end
end
