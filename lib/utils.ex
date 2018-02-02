defmodule Fyyd.Utils do
  @moduledoc """
  Stuff that hasn't found it's place yet.
  """

  @spec extract_from_response(map, [String.t()]) :: [key: :atom]
  def extract_from_response(data, expected_fields \\ []) do
    data
    |> Map.take(expected_fields)
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
  end
end
