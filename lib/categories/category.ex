defmodule Fyyd.Categories.Category do
  @moduledoc false

  alias Fyyd.Utils

  @expected_fields ~w(id name name_de slug subcategories)

  defstruct ~w(id name name_de slug subcategories)a

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          name_de: String.t(),
          slug: String.t(),
          subcategories: [t]
        }

  @doc """
  Takes the `@expected_fields` out of a given map and builds a `%Category{}` struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    category =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    case category.subcategories do
      [] ->
        {:ok, category}

      nil ->
        {:ok, category}

      raw_subcategories when is_list(raw_subcategories) ->
        subcategories =
          raw_subcategories
          |> Stream.map(&extract_from_response/1)
          |> Enum.map(fn {:ok, subcategory} -> subcategory end)

        category_including_subs = Map.put(category, :subcategories, subcategories)

        {:ok, category_including_subs}
    end
  end
end
