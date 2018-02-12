defmodule Fyyd.API do
  @moduledoc """
  The actual Client for the Fyyd HTTP API.
  """

  use HTTPoison.Base

  alias Fyyd.API.Response

  require Logger

  @api_version "0.2"
  @base_url "https://api.fyyd.de"

  @doc """
  Get and unwrap data from the Fyyd HTTP API for the given `url`.

  ## Usage

      {:ok, user_data} = Fyyd.API.get_data("/user?nick=optikfluffel")

  """
  @spec get_data(String.t()) :: {:ok, map} | {:ok, [map]} | {:error, any}
  def get_data(url) do
    with {:ok, response} <- get(url),
         {:ok, data} <- handle_response(response) do
      {:ok, data}
    end
  end

    end
  end

  # ---------------------------------------- HTTPoison.Base specific
  def process_url(url), do: @base_url <> "/" <> @api_version <> url

  def process_response_body(""), do: nil

  def process_response_body(body) do
    Poison.decode!(
      body,
      as: %Response{
        meta: %Response.Meta{
          API_INFO: %Response.APIInfo{}
        }
      }
    )
  end

  # ----------------------------------------Private Helper
  # Unwraps the response data from a given `%HTTPoison.Response{}`.
  defp handle_response(%HTTPoison.Response{status_code: 200, body: %Response{data: data}}) do
    {:ok, data}
  end

  defp handle_response(%HTTPoison.Response{status_code: 404}) do
    {:error, :not_found}
  end

  defp handle_response(response) do
    _ = Logger.error("[Fyyd.API] [handle_response] UNKNOWN RESPONSE")
    _ = Logger.error(inspect(response))
    {:error, :unknown}
  end
end
