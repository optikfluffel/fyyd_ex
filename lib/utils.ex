defmodule Fyyd.Utils do
  @moduledoc """
  Stuff that hasn't found it's place yet.
  """

  @doc """
  Takes a Map, where the keys are Strings, and a List of expected fields.
  Returns Keyword List, where the keys are atoms.

  ## Example

      iex> Fyyd.Utils.extract_from_response(%{"foo" => "bar", "baz" => "-"}, [:foo])
      [foo: "bar"]

      iex> Fyyd.Utils.extract_from_response(%{"without" => "foo key"}, [:foo])
      [foo: nil]

      iex> Fyyd.Utils.extract_from_response(%{"without" => "expected_fields"})
      []

  """
  @spec extract_from_response(map, [atom]) :: [key: :atom]
  def extract_from_response(data, expected_fields \\ []) do
    Enum.map(expected_fields, fn key ->
      value = Map.get(data, to_string(key))

      {key, value}
    end)
  end

  @doc """
  Takes a Keyword List, where the keys are atoms, and a Module name
  and returns a struct built from them.
  """
  @spec struct_from_keyword_list([key: atom], module) :: struct
  def struct_from_keyword_list(list, module), do: struct(module, list)
end
