defmodule Fyyd do
  @moduledoc """
  Documentation for Fyyd.
  """

  alias Fyyd.User
  alias Fyyd.Curations
  alias Fyyd.Curations.Curation
  alias Fyyd.Collections
  alias Fyyd.Collections.Collection

  # ---------------------------------------- 😊 User
  @spec user(integer | String.t()) :: {:ok, User.t()}
  defdelegate user(id), to: User, as: :get

  @spec user_by_nick(String.t()) :: {:ok, User.t()}
  defdelegate user_by_nick(nick), to: User, as: :get_by_nick

  # ---------------------------------------- 📂 Curations
  @spec curations_for_user(integer | String.t(), key: atom) :: {:ok, [Curation.t()]}
  defdelegate curations_for_user(id, opts \\ []), to: Curations, as: :get_for_user

  @spec curations_for_user_by_nick(String.t(), key: atom) :: {:ok, [Curation.t()]}
  defdelegate curations_for_user_by_nick(nick, opts \\ []),
    to: Curations,
    as: :get_for_user_by_nick

  # ---------------------------------------- 📚 Collections
  @spec collections_for_user(integer | String.t()) :: {:ok, [Collection.t()]}
  defdelegate collections_for_user(id), to: Collections, as: :get_for_user

  @spec collections_for_user_by_nick(String.t()) :: {:ok, [Collection.t()]}
  defdelegate collections_for_user_by_nick(nick), to: Collections, as: :get_for_user_by_nick
end
