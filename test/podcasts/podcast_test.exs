defmodule Fyyd.Podcasts.PodcastTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.Podcasts.Podcast
  alias Fyyd.Factory

  describe "extract_from_response/1" do
    property "converts a valid map to a %Podcast{}" do
      check all map <- Factory.podcast_map() do
        assert {:ok, %Podcast{}} = Podcast.extract_from_response(map)
      end
    end

    property "discards unexpected keys" do
      check all map <- Factory.podcast_map() do
        {:ok, podcast} =
          map
          |> Map.put_new("something_strange", "This really shouldn't be here.")
          |> Podcast.extract_from_response()

        refute Map.has_key?(podcast, "something_strange")
        refute Map.has_key?(podcast, :something_strange)
      end
    end
  end
end
