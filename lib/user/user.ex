defmodule Fyyd.User do
  @moduledoc """
  Handles requests regarding User.
  """

  alias Fyyd.API
  alias Fyyd.Utils

  @fields ~w(id nick fullname bio url layoutImageURL thumbImageURL microImageURL)a

  defstruct @fields

  @type t :: %__MODULE__{
          id: integer,
          nick: String.t(),
          fullname: String.t(),
          bio: String.t(),
          url: String.t(),
          layoutImageURL: String.t(),
          thumbImageURL: String.t(),
          microImageURL: String.t()
        }

  @doc """
  Gets public available information about a registered account by it's `id`.
  """
  @spec get(integer | String.t()) :: {:ok, t}
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
  @spec get_by_nick(String.t()) :: {:ok, t}
  def get_by_nick(nick) do
    with {:ok, user_data} <- API.get_data("/user?nick=" <> nick) do
      extract_from_response(user_data)
    end
  end

  @doc """
  Takes the @fields out of a given map and builds a %User{} struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    user =
      data
      |> Utils.extract_from_response(@fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, user}
  end
end
