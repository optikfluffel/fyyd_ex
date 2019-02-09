defmodule Fyyd.Account do
  @moduledoc false

  alias Fyyd.API
  alias Fyyd.Utils
  alias Fyyd.Curations
  alias Fyyd.Curations.Curation
  alias Fyyd.Collections
  alias Fyyd.Collections.Collection

  @fields ~w(id fullname bio nick url layoutImageURL microImageURL smallImageURL thumbImageURL)a

  defstruct @fields

  @type t :: %__MODULE__{
          id: integer,
          fullname: String.t(),
          bio: String.t(),
          nick: String.t(),
          url: String.t(),
          layoutImageURL: String.t(),
          microImageURL: String.t(),
          smallImageURL: String.t(),
          thumbImageURL: String.t()
        }

  @doc """
  Gets the account information of a given access_token's user.

  ## Usage

        {:ok, account} = Fyyd.Account.info(access_token)

  """
  @spec info(String.t()) :: {:ok, t}
  def info(access_token) do
    with {:ok, account_data} <- API.get_authorized_data("/account/info", access_token) do
      extract_from_response(account_data)
    end
  end

  @doc """
  Gets the account's curations of a given access_token's user.

  ## Usage

        {:ok, curations} = Fyyd.Account.curations(access_token)

  """
  @spec curations(String.t()) :: {:ok, [Curation.t()]}
  def curations(access_token) do
    with {:ok, curations_data} <- API.get_authorized_data("/account/curations", access_token) do
      Curations.extract_from_response(curations_data)
    end
  end

  @doc """
  Gets the account's collections of a given access_token's user.

  ## Usage

        {:ok, collections} = Fyyd.Account.collections(access_token)

  """
  @spec collections(String.t()) :: {:ok, [Collection.t()]}
  def collections(access_token) do
    with {:ok, collections_data} <- API.get_authorized_data("/account/collections", access_token) do
      Collections.extract_from_response(collections_data)
    end
  end

  @doc """
  Takes the @fields out of a given map and builds an %Account{} struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    account =
      data
      |> Utils.extract_from_response(@fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, account}
  end
end
