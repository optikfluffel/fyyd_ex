defmodule Fyyd.CurationsTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.Curations
  alias Fyyd.Curations.Curation
  alias Fyyd.Factory

  describe "extract_from_response/1" do
    test "converts a list of valid maps to a List of %Curations{}" do
      {:ok, curations} =
        Factory.curation_map()
        |> Enum.take(:rand.uniform(100))
        |> Curations.extract_from_response()

      assert %Curation{} = curation = Enum.random(curations)
      assert curation.id != nil
    end

    test "works with an empty list" do
      assert {:ok, []} = Curations.extract_from_response([])
    end
  end
end
