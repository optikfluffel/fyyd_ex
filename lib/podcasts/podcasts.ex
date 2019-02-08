defmodule Fyyd.Podcasts do
  @moduledoc false

  alias Fyyd.Podcasts.Podcast

  @spec extract_from_response([map]) :: {:ok, [Podcast.t()]}
  def extract_from_response(list_of_maps) do
    podcasts =
      list_of_maps
      |> Enum.map(&Podcast.extract_from_response/1)
      |> Enum.map(fn {:ok, podcast} -> podcast end)

    {:ok, podcasts}
  end
end
