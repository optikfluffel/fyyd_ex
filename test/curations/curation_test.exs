defmodule Fyyd.Curations.CurationTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.Curations.Curation
  alias Fyyd.Factory

  describe "extract_curation_from_response/1" do
    property "converts a valid map to a %Curation{}" do
      check all map <- Factory.curation_map() do
        assert {:ok, %Curation{}} = Curation.extract_curation_from_response(map)
      end
    end

    property "discards unexpected keys" do
      check all map <- Factory.curation_map() do
        {:ok, curation} =
          map
          |> Map.put_new("something_strange", "This really shouldn't be here.")
          |> Curation.extract_curation_from_response()

        refute Map.has_key?(curation, "something_strange")
        refute Map.has_key?(curation, :something_strange)
      end
    end
  end

  describe "extract_curation_from_response!/1" do
    property "converts a valid map to a %Curation{}" do
      check all map <- Factory.curation_map() do
        assert %Curation{} = Curation.extract_curation_from_response!(map)
      end
    end
  end
end
