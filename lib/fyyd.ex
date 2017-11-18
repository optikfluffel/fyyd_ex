defmodule Fyyd do
  @moduledoc """
  Documentation for Fyyd.
  """

  alias Fyyd.User

  @spec user(integer | String.t) :: {:ok, %User{}}
  defdelegate user(id), to: User, as: :get

  @spec user_by_nick(String.t) :: {:ok, %User{}}
  defdelegate user_by_nick(nick), to: User, as: :get_by_nick
end
