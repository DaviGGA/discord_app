defmodule DiscordAppWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """

  use DiscordAppWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{
      name: "ValidationError",
      error: translate_changeset_errors(changeset)
    })
  end

  def call(conn, {:error, reason}) do
    conn
    |> put_status(400)
    |> json(%{
      name: "BadRequestError",
      error: reason
    })
  end

  def call(conn, nil) do
    conn
    |> put_status(:not_fund)
    |> json(%{
      name: "NotFoundError",
      error: "Value not found"
    })
  end



  defp translate_changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

end
