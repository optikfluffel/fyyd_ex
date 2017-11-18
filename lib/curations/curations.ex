defmodule Fyyd.Curations do
  @moduledoc """
  Handles Curations stuff.
  """

  alias Fyyd.API
  alias Fyyd.Curations.Curation

  @type list_of_curations :: [%Curation{}]

  @doc """
  Gets Curations for a given User by it's `id`.
  """
  @spec get_for_user(integer | String.t) :: {:ok, list_of_curations}
  def get_for_user(id) when is_integer(id) do
    id
    |> Integer.to_string()
    |> get_for_user()
  end
  def get_for_user(id) when is_binary(id) do
    with {:ok, curations_data} <- API.get_data("/user/curations?user_id=" <> id) do
      extract_curations_from_response(curations_data)
    end
  end

  @doc """
  Gets Curations for a given User by it's `nick`.
  """
  @spec get_for_user_by_nick(String.t) :: {:ok, list_of_curations}
  def get_for_user_by_nick(nick) do
    with {:ok, curations_data} <- API.get_data("/user/curations?nick=" <> nick) do
      extract_curations_from_response(curations_data)
    end
  end

  @doc """
  Takes a list of map and builds a list of %Curation{} structs out of it.
  """
  @spec extract_curations_from_response([map]) :: {:ok, list_of_curations}
  def extract_curations_from_response(list_of_maps) when is_list(list_of_maps) do
    curations = Enum.map(list_of_maps, &Curation.extract_curation_from_response!(&1))

    {:ok, curations}
  end
end
