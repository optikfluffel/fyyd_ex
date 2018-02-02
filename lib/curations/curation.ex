defmodule Fyyd.Curations.Curation do
  @moduledoc false

  alias Fyyd.Utils

  @expected_fields ~w(id title description public type slug url xmlURL
                      layoutImageURL thumbImageURL microImageURL)

  defstruct ~w(id title description public type slug url xmlURL
               layoutImageURL thumbImageURL microImageURL)a

  @doc """
  Takes the @expected_fields out of a given map and builds a %Curation{} struct out of it.
  """
  @spec extract_curation_from_response!(map) :: %__MODULE__{}
  def extract_curation_from_response!(map) do
    with {:ok, curation} <- extract_curation_from_response(map) do
      curation
    end
  end

  @doc false
  @spec extract_curation_from_response(map) :: {:ok, %__MODULE__{}}
  def extract_curation_from_response(data) do
    curation =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, curation}
  end
end
