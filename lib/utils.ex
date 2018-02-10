defmodule Fyyd.Utils do
  @moduledoc """
  Stuff that hasn't found it's place yet.
  """

  @doc """
  Takes a Map, where the keys are Strings, and a List of expected fields.
  Returns Keyword List, where the keys are atoms.

  ## Example

      iex> Fyyd.Utils.extract_from_response(%{"foo" => "bar"}, ["foo"])
      [foo: "bar"]
      
  """
  @spec extract_from_response(map, [String.t()]) :: [key: :atom]
  def extract_from_response(data, expected_fields \\ []) do
    data
    |> Map.take(expected_fields)
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
  end

  @doc """
  Takes a Keyword List, where the keys are atoms, and a Module name
  and returns a struct built from them.
  """
  @spec struct_from_keyword_list([key: atom], module) :: struct
  def struct_from_keyword_list(list, module), do: struct(module, list)
end
