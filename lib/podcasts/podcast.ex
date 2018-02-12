defmodule Fyyd.Podcasts.Podcast do
  @moduledoc false

  alias Fyyd.Episodes
  alias Fyyd.Episodes.Episode
  alias Fyyd.Utils

  @expected_fields ~w(id description episode_count etag generator htmlURL imgURL language
                      lastmodified lastpoll lastpub layoutImageURL md5body microImageURL
                      rank slug smallImageURL status subtitle thumbImageURL title url_fyyd
                      xmlUrl episodes)

  defstruct ~w(id description episode_count etag generator htmlURL imgURL language
               lastmodified lastpoll lastpub layoutImageURL md5body microImageURL
               rank slug smallImageURL status subtitle thumbImageURL title url_fyyd
               xmlUrl episodes)a

  @type t :: %__MODULE__{
          id: integer,
          description: String.t(),
          episode_count: integer,
          etag: String.t(),
          generator: String.t(),
          htmlURL: String.t(),
          imgURL: String.t(),
          language: String.t(),
          lastmodified: String.t(),
          lastpoll: String.t(),
          lastpub: String.t(),
          layoutImageURL: String.t(),
          md5body: String.t(),
          microImageURL: String.t(),
          rank: integer,
          slug: String.t(),
          smallImageURL: String.t(),
          status: integer,
          subtitle: String.t(),
          thumbImageURL: String.t(),
          title: String.t(),
          url_fyyd: String.t(),
          xmlUrl: String.t(),
          episodes: [Episode.t()]
        }

  @doc """
  Takes the `@expected_fields` out of a given map and builds a `%Podcast{}` struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    podcast =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, podcast}
  end

  @doc """
  Same as `extract_from_response/1`, but includes episodes
  """
  @spec extract_from_response_with_episodes(map) :: {:ok, t}
  def extract_from_response_with_episodes(data) do
    podcast_with_raw_episodes = Utils.extract_from_response(data, @expected_fields)

    {:episodes, raw_episodes} =
      podcast_with_raw_episodes
      |> Enum.find(fn {key, _value} -> key == :episodes end)

    {:ok, episodes} = Episodes.extract_from_response(raw_episodes)

    podcast =
      podcast_with_raw_episodes
      |> Enum.filter(fn {key, _value} -> key != :episodes end)
      |> Enum.concat([{:episodes, episodes}])
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, podcast}
  end
end
