defmodule Fyyd.API do
  @moduledoc """
  The actual Client for the Fyyd HTTP API.
  """

  use HTTPoison.Base

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

  @doc """
  Get and unwrap data, where authorization is needed for the given `url` and `access_token`.

  ## Usage

      {:ok, account_data} = Fyyd.API.get_authorized_data("/account/info", access_token)

  """
  @spec get_authorized_data(String.t(), String.t()) :: {:ok, map} | {:ok, [map]} | {:error, any}
  def get_authorized_data(url, access_token) do
    with {:ok, headers} <- auth_header(access_token),
         {:ok, response} <- get(url, headers),
         {:ok, data} <- handle_response(response) do
      {:ok, data}
    end
  end

  @doc """
  Helper to get the authorization url with a given `client_id`.
  For details have a look at https://github.com/eazyliving/fyyd-api#authorization.

  ## Example

      iex> Fyyd.API.authorize_url("1a2b3c")
      "https://fyyd.de/oauth/authorize?client_id=1a2b3c"

  """
  @spec authorize_url(String.t()) :: String.t()
  def authorize_url(client_id) do
    "https://fyyd.de/oauth/authorize?client_id=#{client_id}"
  end

  # ---------------------------------------- HTTPoison.Base specific
  def process_request_url(url), do: @base_url <> "/" <> @api_version <> url

  def process_response_body(""), do: nil

  def process_response_body(body) do
    Jason.decode!(body)
  end

  # ----------------------------------------Private Helper
  # Unwraps the response data from a given `%HTTPoison.Response{}`.
  defp handle_response(%HTTPoison.Response{status_code: 200, body: %{"data" => data}}) do
    {:ok, data}
  end

  defp handle_response(%HTTPoison.Response{status_code: 401}) do
    {:error, :unauthorized}
  end

  defp handle_response(%HTTPoison.Response{status_code: 404}) do
    {:error, :not_found}
  end

  # Generates an authorization header from a given `access_token`.
  defp auth_header(access_token) do
    header = [{"Authorization", "Bearer #{access_token}"}]

    {:ok, header}
  end
end
