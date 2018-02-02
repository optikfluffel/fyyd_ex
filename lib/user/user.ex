defmodule Fyyd.User do
  @moduledoc """
  Handles requests regarding User.
  """

  alias Fyyd.API
  alias Fyyd.Utils

  @expected_fields ~w(id nick fullname bio url layoutImageURL thumbImageURL microImageURL)

  defstruct ~w(id nick fullname bio url layoutImageURL thumbImageURL microImageURL)a

  @doc """
  Gets public available information about a registered account by it's `id`.
  """
  @spec get(integer | String.t()) :: {:ok, %__MODULE__{}}
  def get(id) when is_integer(id) do
    id
    |> Integer.to_string()
    |> get()
  end

  def get(id) when is_binary(id) do
    with {:ok, user_data} <- API.get_data("/user?user_id=" <> id) do
      extract_from_response(user_data)
    end
  end

  @doc """
  Gets public available information about a registered account by it's `nick`.
  """
  @spec get_by_nick(String.t()) :: {:ok, %__MODULE__{}}
  def get_by_nick(nick) do
    with {:ok, user_data} <- API.get_data("/user?nick=" <> nick) do
      extract_from_response(user_data)
    end
  end

  @doc """
  Takes the @expected_fields out of a given map and builds a %User{} struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, %__MODULE__{}}
  def extract_from_response(data) do
    user =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, user}
  end
end
