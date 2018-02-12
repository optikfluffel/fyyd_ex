defmodule Fyyd.Account do
  @moduledoc false

  alias Fyyd.API
  alias Fyyd.Utils

  @expected_fields ~w(id fullname bio nick url
                      layoutImageURL microImageURL smallImageURL thumbImageURL)

  defstruct ~w(id fullname bio nick url layoutImageURL microImageURL smallImageURL thumbImageURL)a

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
  Takes the @expected_fields out of a given map and builds an %Account{} struct out of it.
  """
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    account =
      data
      |> Utils.extract_from_response(@expected_fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, account}
  end
end
