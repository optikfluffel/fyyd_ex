defmodule Fyyd.API do
  @moduledoc """
  The actual Client for the Fyyd HTTP API.
  """

  use HTTPoison.Base

  alias Fyyd.API.Response

  @api_version "0.2"
  @base_url "https://api.fyyd.de"

  def get_data!(url) do
    url
    |> get!()
    |> Map.get(:body)
    |> Map.get(:data)
  end

  def process_url(url), do: @base_url <> "/" <> @api_version <> url

  def process_response_body(body) do
    Poison.decode!(body, as: %Response{
      meta: %Response.Meta{
        API_INFO: %Response.APIInfo{}
      }
    })
  end
end
