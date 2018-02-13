defmodule Fyyd.CategoryTreeTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.Categories.CategoryTree
  alias Fyyd.Categories.CategoryTree.Category
  alias Fyyd.Factory

  describe "extract_from_response/1" do
    test "converts a list of valid maps to a List of %Category{}" do
      {:ok, categories} =
        Factory.category_map_without_subs()
        |> Enum.take(:rand.uniform(100))
        |> CategoryTree.extract_from_response()

      assert %Category{} = List.first(categories)
    end

    test "works with an empty list" do
      assert {:ok, []} = CategoryTree.extract_from_response([])
    end
  end
end
