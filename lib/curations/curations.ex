defmodule Fyyd.Curations do
  @moduledoc """
  Handles Curations stuff.
  """

  alias Fyyd.API
  alias Fyyd.Curations.Curation

  @doc """
  Gets Curations for a given User by it's `id`.
  """
  @spec get_for_user(integer | String.t(), key: atom) :: {:ok, [%Curation{}]}
  def get_for_user(id, opts) when is_integer(id) do
    id
    |> Integer.to_string()
    |> get_for_user(opts)
  end

  def get_for_user(id, []) when is_binary(id) do
    with {:ok, curations_data} <- API.get_data("/user/curations?user_id=" <> id) do
      extract_from_response(curations_data)
    end
  end

  def get_for_user(id, include: :episodes) when is_binary(id) do
    with {:ok, curations_data} <- API.get_data("/user/curations/episodes?user_id=" <> id) do
      extract_from_response_with_episodes(curations_data)
    end
  end

  @doc """
  Gets Curations for a given User by it's `nick`.
  """
  @spec get_for_user_by_nick(String.t(), key: atom) :: {:ok, [%Curation{}]}
  def get_for_user_by_nick(nick, []) do
    with {:ok, curations_data} <- API.get_data("/user/curations?nick=" <> nick) do
      extract_from_response(curations_data)
    end
  end

  def get_for_user_by_nick(nick, include: :episodes) do
    with {:ok, curations_data} <- API.get_data("/user/curations/episodes?nick=" <> nick) do
      extract_from_response_with_episodes(curations_data)
    end
  end

  @doc """
  Takes a list of map and builds a list of %Curation{} structs out of it.
  """
  @spec extract_from_response([map]) :: {:ok, [%Curation{}]}
  def extract_from_response(list_of_maps) when is_list(list_of_maps) do
    curations =
      list_of_maps
      |> Enum.map(&Curation.extract_from_response/1)
      |> Enum.map(fn {:ok, curation} -> curation end)

    {:ok, curations}
  end

  @spec extract_from_response_with_episodes([map]) :: {:ok, [%Curation{}]}
  def extract_from_response_with_episodes(list_of_maps) when is_list(list_of_maps) do
    curations =
      list_of_maps
      |> Enum.map(&Curation.extract_from_response_with_episodes/1)
      |> Enum.map(fn {:ok, curation} -> curation end)

    {:ok, curations}
  end
end
