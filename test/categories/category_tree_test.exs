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

  describe "CategoryTree.Category.extract_from_response/1" do
    property "converts a valid map to a %Category{}" do
      check all map <- Factory.category_map_without_subs() do
        assert {:ok, %Category{}} = Category.extract_from_response(map)
      end
    end

    property "converts a valid map to a %Category{} when subcategories are included" do
      check all map <- Factory.category_map_with_subs() do
        assert {:ok, %Category{}} = Category.extract_from_response(map)
      end
    end

    property "discards unexpected keys" do
      check all map <- Factory.category_map_without_subs() do
        {:ok, category} =
          map
          |> Map.put_new("something_strange", "This really shouldn't be here.")
          |> Category.extract_from_response()

        refute Map.has_key?(category, "something_strange")
        refute Map.has_key?(category, :something_strange)
      end
    end
  end
end
