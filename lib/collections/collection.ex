defmodule Fyyd.Collections.Collection do
  @moduledoc false

  alias Fyyd.Utils
  alias Fyyd.Podcasts
  alias Fyyd.Podcasts.Podcast

  @expected_fields ~w(id title description layoutImageURL thumbImageURL microImageURL
                      smallImageURL slug url user_id podcasts)

  defstruct ~w(id title description layoutImageURL thumbImageURL microImageURL
               smallImageURL slug url user_id podcasts)a

  @type t :: %__MODULE__{
          id: integer,
          title: String.t(),
          description: String.t(),
          layoutImageURL: String.t(),
          thumbImageURL: String.t(),
          microImageURL: String.t(),
          smallImageURL: String.t(),
          slug: String.t(),
          url: String.t(),
          user_id: integer,
          podcasts: [Podcast.t()]
        }

  @doc """
  Takes the @expected_fields out of a given map and builds a %Collection{} struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    collection =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, collection}
  end

  @doc """
  Same as `extract_from_response/1` but including podcasts.
  """
  @spec extract_from_response_with_podcasts(map) :: {:ok, t}
  def extract_from_response_with_podcasts(data) do
    collection_with_raw_podcasts = Utils.extract_from_response(data, @expected_fields)

    {:podcasts, raw_podcasts} =
      collection_with_raw_podcasts
      |> Enum.find(fn {key, _value} -> key == :podcasts end)

    {:ok, podcasts} = Podcasts.extract_from_response(raw_podcasts)

    collection =
      collection_with_raw_podcasts
      |> Enum.filter(fn {key, _value} -> key != :podcasts end)
      |> Enum.concat([{:podcasts, podcasts}])
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, collection}
  end
end
