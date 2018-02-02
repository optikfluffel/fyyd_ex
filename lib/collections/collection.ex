defmodule Fyyd.Collections.Collection do
  @moduledoc false

  alias Fyyd.Utils

  @expected_fields ~w(id title description layoutImageURL thumbImageURL microImageURL
                      smallImageURL slug url user_id)

  defstruct ~w(id title description layoutImageURL thumbImageURL microImageURL
               smallImageURL slug url user_id)a

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
          user_id: integer
        }

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
