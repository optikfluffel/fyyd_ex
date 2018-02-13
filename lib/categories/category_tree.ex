defmodule Fyyd.Categories.CategoryTree do
  @moduledoc false

  alias Fyyd.Categories.CategoryTree.Category

  @doc """
  Takes a list of maps and builds a list of %Category{} structs out of it.
  """
  @spec extract_from_response([map]) :: {:ok, [Category.t()]}
  def extract_from_response(list_of_maps) when is_list(list_of_maps) do
    categories =
      list_of_maps
      |> Stream.map(&Category.extract_from_response/1)
      |> Enum.map(fn {:ok, category} -> category end)

    {:ok, categories}
  end
end

defmodule Fyyd.Categories.CategoryTree.Category do
  @moduledoc false
  alias Fyyd.Utils
  alias Fyyd.Categories.CategoryTree.Subcategory

  @expected_fields ~w(id name name_de slug subcategories)

  defstruct ~w(id name name_de slug subcategories)a

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          name_de: String.t(),
          slug: String.t(),
          subcategories: [Subcategory.t()]
        }

  @doc """
  Takes the `@expected_fields` out of a given map and builds a `%Category{}` struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    subcategories =
      data
      |> Map.get("subcategories")
      |> Stream.map(&Subcategory.extract_from_response/1)
      |> Enum.map(fn {:ok, subcategory} -> subcategory end)

    category_without_subs =
      data
      |> Utils.extract_from_response(@expected_fields -- ["subcategories"])
      |> Utils.struct_from_keyword_list(__MODULE__)

    category = Map.put(category_without_subs, :subcategories, subcategories)

    {:ok, category}
  end
end

defmodule Fyyd.Categories.CategoryTree.Subcategory do
  @moduledoc false
  alias Fyyd.Utils

  @expected_fields ~w(id name name_de slug)

  defstruct ~w(id name name_de slug)a

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          name_de: String.t(),
          slug: String.t()
        }

  @doc """
  Takes the `@expected_fields` out of a given map and builds a `%Subcategory{}` struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    subcategory =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, subcategory}
  end
end
