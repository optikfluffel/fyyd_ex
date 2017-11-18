defmodule Fyyd do
  @moduledoc """
  Documentation for Fyyd.
  """

  alias Fyyd.User

  defdelegate user!(id), to: User, as: :get!
  defdelegate user_by_nick!(nick), to: User, as: :get_by_nick!
end
