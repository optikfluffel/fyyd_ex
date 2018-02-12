defmodule Fyyd.Categories do
  @moduledoc false

  alias Fyyd.API
  alias Fyyd.Categories.Category

  @doc """
  Gets the complete categories tree.
  """
  @spec all :: {:ok, [Category.t()]}
  def all do
    with {:ok, categories_data} <- API.get_data("/categories") do
      extract_from_response(categories_data)
    end
  end

  @doc """
  Takes a list of maps and builds a list of %Category{} structs out of it.
  """
  @spec extract_from_response([map]) :: {:ok, [Category.t()]}
  def extract_from_response(list_of_maps) when is_list(list_of_maps) do
    categories =
      list_of_maps
      |> Enum.map(&Category.extract_from_response/1)
      |> Enum.map(fn {:ok, category} -> category end)

    {:ok, categories}
  end
end
