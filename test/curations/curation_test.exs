defmodule Fyyd.Curations.CurationTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.Curations.Curation
  alias Fyyd.Episodes.Episode
  alias Fyyd.Factory

  describe "extract_from_response/1" do
    property "converts a valid map to a %Curation{}" do
      check all map <- Factory.curation_map() do
        assert {:ok, %Curation{}} = Curation.extract_from_response(map)
      end
    end

    property "discards unexpected keys" do
      check all map <- Factory.curation_map() do
        {:ok, curation} =
          map
          |> Map.put_new("something_strange", "This really shouldn't be here.")
          |> Curation.extract_from_response()

        refute Map.has_key?(curation, "something_strange")
        refute Map.has_key?(curation, :something_strange)
      end
    end
  end

  describe "extract_from_response_with_episodes/1" do
    property "converts a valid map to a %Curation{}" do
      check all map <- Factory.curation_map_with_episodes() do
        assert {:ok, %Curation{} = curation} = Curation.extract_from_response_with_episodes(map)

        if length(curation.episodes) > 0 do
          assert %Episode{} = List.first(curation.episodes)
        end
      end
    end
  end
end
