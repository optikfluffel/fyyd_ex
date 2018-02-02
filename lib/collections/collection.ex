defmodule Fyyd.Collections.Collection do
  @moduledoc false

  alias Fyyd.Utils

  @expected_fields ~w(id title description layoutImageURL thumbImageURL microImageURL
                      smallImageURL slug url user_id)

  defstruct ~w(id title description layoutImageURL thumbImageURL microImageURL
               smallImageURL slug url user_id)a

  @doc """
  Takes the @expected_fields out of a given map and builds a %Collection{} struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, %__MODULE__{}}
  def extract_from_response(data) do
    collection =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, collection}
  end
end
