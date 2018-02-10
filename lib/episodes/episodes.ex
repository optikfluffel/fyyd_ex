defmodule Fyyd.Episodes do
  @moduledoc """
  Handles Episodes stuff.
  """

  alias Fyyd.Episodes.Episode

  @spec extract_from_response([map]) :: {:ok, [Episode.t()]}
  def extract_from_response(list_of_maps) do
    episodes =
      list_of_maps
      |> Enum.map(&Episode.extract_from_response/1)
      |> Enum.map(fn {:ok, episode} -> episode end)

    {:ok, episodes}
  end
end
