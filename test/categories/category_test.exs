defmodule Fyyd.Categories.CategoryTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.Categories.Category
  alias Fyyd.Factory

  describe "extract_from_response/1" do
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
