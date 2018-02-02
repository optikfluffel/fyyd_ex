defmodule Fyyd.Collections.CollectionTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.Collections.Collection
  alias Fyyd.Factory

  describe "extract_from_response/1" do
    property "converts a valid map to a %Collection{}" do
      check all map <- Factory.collection_map() do
        assert {:ok, %Collection{}} = Collection.extract_from_response(map)
      end
    end

    property "discards unexpected keys" do
      check all map <- Factory.collection_map() do
        {:ok, collection} =
          map
          |> Map.put_new("something_strange", "This really shouldn't be here.")
          |> Collection.extract_from_response()

        refute Map.has_key?(collection, "something_strange")
        refute Map.has_key?(collection, :something_strange)
      end
    end
  end
end
