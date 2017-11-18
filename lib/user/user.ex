defmodule Fyyd.User do
  @moduledoc """
  Handles requests regarding User.
  """

  alias Fyyd.API

  @expected_fields ~w(id nick fullname bio url layoutImageURL thumbImageURL microImageURL)

  defstruct ~w(id nick fullname bio url layoutImageURL thumbImageURL microImageURL)a

  @doc """
  Gets public available information about a registered account by it's `id`.
  """
  @spec get(integer | String.t) :: {:ok, %__MODULE__{}}
  def get(id) when is_integer(id) do
    id
    |> Integer.to_string()
    |> get()
  end
  def get(id) when is_binary(id) do
    with {:ok, user_data} <- API.get_data("/user?user_id=" <> id) do
      extract_user_from_response(user_data)
    end
  end

  @doc """
  Gets public available information about a registered account by it's `nick`.
  """
  @spec get_by_nick(String.t) :: {:ok, %__MODULE__{}}
  def get_by_nick(nick) do
    with {:ok, user_data} <- API.get_data("/user?nick=" <> nick) do
      extract_user_from_response(user_data)
    end
  end

  # ---------------------------------------- HTTPoison.Base specific
  @doc """
  Takes the @expected_fields out of a given map and builds a %User{} struct out of it.
  """
  def extract_user_from_response(data) do
    user = data
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
    |> from_keyword_list()

    {:ok, user}
  end

  # build a %User{} struct from the given keyword list
  defp from_keyword_list(list), do: struct(__MODULE__, list)
end
