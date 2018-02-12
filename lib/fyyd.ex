defmodule Fyyd do
  @moduledoc """
  Documentation for Fyyd.
  """

  alias Fyyd.Account
  alias Fyyd.User
  alias Fyyd.Curations
  alias Fyyd.Curations.Curation
  alias Fyyd.Collections
  alias Fyyd.Collections.Collection
  alias Fyyd.Podcasts
  alias Fyyd.Podcasts.Podcast

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
  @spec collections_for_user(integer | String.t(), key: atom) :: {:ok, [Collection.t()]}
  defdelegate collections_for_user(id, opts \\ []), to: Collections, as: :get_for_user

  @spec collections_for_user_by_nick(String.t(), key: atom) :: {:ok, [Collection.t()]}
  defdelegate collections_for_user_by_nick(nick, opts \\ []),
    to: Collections,
    as: :get_for_user_by_nick

  # ---------------------------------------- 👤 Account
  @spec account_info(String.t()) :: {:ok, Account.t()}
  defdelegate account_info(access_token), to: Account, as: :info

  @spec account_curations(String.t()) :: {:ok, [Curation.t()]}
  defdelegate account_curations(access_token), to: Account, as: :curations

  @spec account_collections(String.t()) :: {:ok, [Collection.t()]}
  defdelegate account_collections(access_token), to: Account, as: :collections

  # ---------------------------------------- 🎧 Podcasts
  @spec podcast(integer | String.t(), key: atom) :: {:ok, Podcast.t()}
  defdelegate podcast(id_or_slug, opts \\ []), to: Podcasts, as: :get
end
