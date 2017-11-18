defmodule Fyyd.UserTest do
  @moduledoc false

  use ExUnit.Case, async: false
  use ExUnitProperties
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Fyyd.User
  alias Fyyd.Factory

  doctest User

  setup_all do
    HTTPoison.start()
  end

  describe "get/1" do
    test "gets a User by it's id" do
      use_cassette "user_id" do
        known_user = Factory.optikfluffel()

        assert {:ok, ^known_user} = User.get(known_user.id)
      end
    end

    test "gets a User by it's id, where id is a string" do
      use_cassette "user_id" do
        known_user = Factory.optikfluffel()

        assert {:ok, ^known_user} = known_user.id
        |> Integer.to_string()
        |> User.get()
      end
    end
  end

  describe "get_by_nick/1" do
    test "gets a User by it's id" do
      use_cassette "user_nick" do
        known_user = Factory.optikfluffel()

        assert {:ok, ^known_user} = User.get_by_nick(known_user.nick)
      end
    end
  end

  describe "extract_user_from_response/1" do
    property "converts a valid map to a %User{}" do
      check all map <- Factory.user_map() do
        user_id = map["id"]

        assert {:ok, %User{id: ^user_id}} = User.extract_user_from_response(map)
      end
    end

    property "discards unexpected keys" do
      check all map <- Factory.user_map() do
        {:ok, user} = map
        |> Map.put_new("something_strange", "This really shouldn't be here.")
        |> User.extract_user_from_response()

        refute Map.has_key?(user, "something_strange")
        refute Map.has_key?(user, :something_strange)
      end
    end
  end
end
