defmodule Fyyd.Collections do
  @moduledoc false

  alias Fyyd.API
  alias Fyyd.Collections.Collection

  @doc """
  Gets Collections for a given User by it's `id`.
  """
  @spec get_for_user(integer | String.t()) :: {:ok, [%Collection{}]}
  def get_for_user(id) when is_integer(id) do
    id
    |> Integer.to_string()
    |> get_for_user()
  end

  def get_for_user(id) when is_binary(id) do
    with {:ok, collections_data} <- API.get_data("/user/collections?user_id=" <> id) do
      extract_from_response(collections_data)
    end
  end

  @doc """
  Gets Collections for a given User by it's `nick`.
  """
  @spec get_for_user_by_nick(String.t()) :: {:ok, [%Collection{}]}
  def get_for_user_by_nick(nick) do
    with {:ok, collections_data} <- API.get_data("/user/collections?nick=" <> nick) do
      extract_from_response(collections_data)
    end
  end

  @doc """
  Takes a list of map and builds a list of %Collection{} structs out of it.
  """
  @spec extract_from_response([map]) :: {:ok, [%Collection{}]}
  def extract_from_response(list_of_maps) when is_list(list_of_maps) do
    collections =
      list_of_maps
      |> Enum.map(&Collection.extract_from_response/1)
      |> Enum.map(fn {:ok, collection} -> collection end)

    {:ok, collections}
  end
end
