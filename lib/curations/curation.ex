defmodule Fyyd.Curations.Curation do
  @moduledoc false

  alias Fyyd.Utils
  alias Fyyd.Episodes

  @expected_fields ~w(id title description public type slug url xmlURL
                      layoutImageURL thumbImageURL microImageURL episodes)

  defstruct ~w(id title description public type slug url xmlURL
               layoutImageURL thumbImageURL microImageURL episodes)a

  @doc """
  Takes the @expected_fields out of a given map and builds a %Curation{} struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, %__MODULE__{}}
  def extract_from_response(data) do
    curation =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, curation}
  end

  @doc """
  Same as extract_from_response/1, but includes episodes
  """
  @spec extract_from_response_with_episodes(map) :: {:ok, %__MODULE__{}}
  def extract_from_response_with_episodes(data) do
    curation_with_raw_episodes = Utils.extract_from_response(data, @expected_fields)

    {:episodes, raw_episodes} =
      curation_with_raw_episodes
      |> Enum.find(fn {key, _value} -> key == :episodes end)

    {:ok, episodes} = Episodes.extract_from_response(raw_episodes)

    curation =
      curation_with_raw_episodes
      |> Enum.filter(fn {key, _value} -> key != :episodes end)
      |> Enum.concat([{:episodes, episodes}])
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, curation}
  end
end
