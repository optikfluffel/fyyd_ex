defmodule Fyyd.Episodes.Episode do
  @moduledoc false

  alias Fyyd.Utils

  @expected_fields ~w(id guid title url enclosure podcast_id imgURL
                      pubdate duration url_fyyd description)

  defstruct ~w(id guid title url enclosure podcast_id imgURL
               pubdate duration url_fyyd description)a

  @doc false
  @spec extract_from_response(map) :: {:ok, %__MODULE__{}}
  def extract_from_response(data) do
    episode =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, episode}
  end
end
