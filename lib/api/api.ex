defmodule Fyyd.API do
  @moduledoc """
  The actual Client for the Fyyd HTTP API.
  """

  use HTTPoison.Base

  alias Fyyd.API.Response

  require Logger

  @api_version "0.2"
  @base_url "https://api.fyyd.de"

  @spec get_data(String.t) :: {:ok, map} | {:error, :not_found}
  def get_data(url) do
    case get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: %Response{data: data}}} ->
        {:ok, data}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}
    end
  end

  def process_url(url), do: @base_url <> "/" <> @api_version <> url

  def process_response_body(""), do: nil
  def process_response_body(body) do
    Poison.decode!(body, as: %Response{
      meta: %Response.Meta{
        API_INFO: %Response.APIInfo{}
      }
    })
  end
end
