defmodule Fyyd.UserTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.User
  alias Fyyd.Factory

  describe "extract_from_response/1" do
    property "converts a valid map to a %User{}" do
      check all map <- Factory.user_map() do
        user_id = map["id"]

        assert {:ok, %User{id: ^user_id}} = User.extract_from_response(map)
      end
    end

    property "discards unexpected keys" do
      check all map <- Factory.user_map() do
        {:ok, user} =
          map
          |> Map.put_new("something_strange", "This really shouldn't be here.")
          |> User.extract_from_response()

        refute Map.has_key?(user, "something_strange")
        refute Map.has_key?(user, :something_strange)
      end
    end
  end
end
