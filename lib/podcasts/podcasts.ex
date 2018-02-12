defmodule Fyyd.Podcasts do
  @moduledoc """
  Handles API requests for Podcasts.
  """

  alias Fyyd.API
  alias Fyyd.Podcasts.Podcast

  @doc """
  Gets public available information about a Podcast by it's `id` or `slug`.
  """
  @spec get(integer | String.t(), key: atom) :: {:ok, Podcast.t()}
  def get(id, []) when is_integer(id) do
    with {:ok, podcast_data} <- API.get_data("/podcast?podcast_id=" <> to_string(id)) do
      Podcast.extract_from_response(podcast_data)
    end
  end

  def get(id, include: :episodes) when is_integer(id) do
    with {:ok, curations_data} <- API.get_data("/podcast/episodes?podcast_id=" <> to_string(id)) do
      Podcast.extract_from_response_with_episodes(curations_data)
    end
  end

  def get(slug, []) when is_binary(slug) do
    with {:ok, podcast_data} <- API.get_data("/podcast?podcast_slug=" <> slug) do
      Podcast.extract_from_response(podcast_data)
    end
  end

  def get(slug, include: :episodes) when is_binary(slug) do
    with {:ok, curations_data} <- API.get_data("/podcast/episodes?podcast_slug=" <> slug) do
      Podcast.extract_from_response_with_episodes(curations_data)
    end
  end

  @spec extract_from_response([map]) :: {:ok, [Podcast.t()]}
  def extract_from_response(list_of_maps) do
    podcasts =
      list_of_maps
      |> Stream.map(&Podcast.extract_from_response/1)
      |> Enum.map(fn {:ok, podcast} -> podcast end)

    {:ok, podcasts}
  end
end
