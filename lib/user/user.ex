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
  def get!(id) when is_integer(id) do
    id
    |> Integer.to_string()
    |> get!()
  end
  def get!(id) when is_binary(id) do
    "/user?user_id=" <> id
    |> API.get_data!()
    |> extract_user_from_response()
  end

  @doc """
  Gets public available information about a registered account by it's `nick`.
  """
  def get_by_nick!(nick) do
    "/user?nick=" <> nick
    |> API.get_data!()
    |> extract_user_from_response()
  end

  @doc """
  Takes the @expected_fields out of a given map and builds a %User{} struct out of it.
  """
  def extract_user_from_response(data) do
    data
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
    |> from_keyword_list()
  end

  # build a %User{} struct from the given keyword list
  defp from_keyword_list(list), do: struct(__MODULE__, list)
end
