defmodule Fyyd.Categories do
  @moduledoc false

  alias Fyyd.API
  alias Fyyd.Categories.Category
  alias Fyyd.Categories.CategoryTree

  @doc """
  Gets the complete categories tree.
  """
  @spec tree :: {:ok, CategoryTree.t()}
  def tree do
    with {:ok, categories_data} <- API.get_data("/categories") do
      CategoryTree.extract_from_response(categories_data)
    end
  end
end