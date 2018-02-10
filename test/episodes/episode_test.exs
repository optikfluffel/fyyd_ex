defmodule Fyyd.Episodes.EpisodeTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.Episodes.Episode
  alias Fyyd.Factory

  describe "extract_from_response/1" do
    property "converts a valid map to a %Episode{}" do
      check all map <- Factory.episode_map() do
        assert {:ok, %Episode{}} = Episode.extract_from_response(map)
      end
    end

    property "discards unexpected keys" do
      check all map <- Factory.episode_map() do
        {:ok, episode} =
          map
          |> Map.put_new("something_strange", "This really shouldn't be here.")
          |> Episode.extract_from_response()

        refute Map.has_key?(episode, "something_strange")
        refute Map.has_key?(episode, :something_strange)
      end
    end
  end
end
