defmodule DiscordAppWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """

  use DiscordAppWeb, :controller

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{
      name: "ValidationError",
      error: translate_errors(changeset)
    })
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

end
