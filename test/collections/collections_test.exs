defmodule Fyyd.CollectionsTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Fyyd.Collections
  alias Fyyd.Collections.Collection
  alias Fyyd.Factory

  describe "extract_from_response/1" do
    test "converts a list of valid maps to a List of %Collections{}" do
      {:ok, collections} =
        Factory.collection_map()
        |> Enum.take(:rand.uniform(100))
        |> Collections.extract_from_response()

      assert %Collection{} = random_collection = Enum.random(collections)
      assert random_collection.id != nil
    end

    test "works with an empty list" do
      assert {:ok, []} = Collections.extract_from_response([])
    end
  end
end
