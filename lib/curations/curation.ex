defmodule Fyyd.Curations.Curation do
  @moduledoc false

  alias Fyyd.Utils
  alias Fyyd.Episodes
  alias Fyyd.Episodes.Episode

  @fields ~w(id title description public type slug url xmlURL
                      layoutImageURL thumbImageURL microImageURL episodes)a

  defstruct @fields

  @type t :: %__MODULE__{
          id: integer,
          title: String.t(),
          description: String.t(),
          public: integer,
          type: integer,
          slug: String.t(),
          url: String.t(),
          xmlURL: String.t(),
          layoutImageURL: String.t(),
          thumbImageURL: String.t(),
          microImageURL: String.t(),
          episodes: [Episode.t()]
        }

  @doc """
  Takes the `@fields` out of a given map and builds a `%Curation{}` struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    curation =
      data
      |> Utils.extract_from_response(@fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, curation}
  end

  @doc """
  Same as `extract_from_response/1`, but includes episodes
  """
  @spec extract_from_response_with_episodes(map) :: {:ok, t}
  def extract_from_response_with_episodes(data) do
    curation_with_raw_episodes = Utils.extract_from_response(data, @fields)

    {:episodes, raw_episodes} =
      curation_with_raw_episodes
      |> Enum.find(fn {key, _value} -> key == :episodes end)

    {:ok, episodes} = Episodes.extract_from_response(raw_episodes)

    curation =
      curation_with_raw_episodes
      |> Stream.filter(fn {key, _value} -> key != :episodes end)
      |> Enum.concat([{:episodes, episodes}])
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, curation}
  end
end
