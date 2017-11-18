defmodule Fyyd.UserTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.User
  alias Fyyd.Factory

  @optikfluffel %User{
    bio: "Just looking around.",
    fullname: "optikfluffel",
    id: 2078,
    layoutImageURL: "https://img.fyyd.de/user/layout/2078.jpg?et=644a12a72e1f75f671ede648850a0b98",
    microImageURL: "https://img.fyyd.de/user/micro/2078.png?et=644a12a72e1f75f671ede648850a0b98",
    nick: "optikfluffel",
    thumbImageURL: "https://img.fyyd.de/user/thumbs/2078.png?et=644a12a72e1f75f671ede648850a0b98",
    url: "https://www.instagram.com/optikfluffel/"
  }

  doctest User

  describe "get!/1" do
    test "gets a User by it's id" do
      assert User.get!(2078) == @optikfluffel
    end

    test "gets a User by it's id, where id is a string" do
      assert User.get!("2078") == @optikfluffel
    end
  end

  describe "get_by_nick!/1" do
    test "gets a User by it's id" do
      assert User.get_by_nick!("optikfluffel") == @optikfluffel
    end
  end

  describe "extract_user_from_response/1" do
    property "converts a valid map to a %User{}" do
      check all map <- Factory.user_map do
        user_id = map["id"]

        assert %User{id: ^user_id} = User.extract_user_from_response(map)
      end
    end

    property "discards unexpected keys" do
      check all valid_map <- Factory.user_map do
        map = Map.put_new(valid_map, "something_strange", "This really shouldn't be here.")
        user = User.extract_user_from_response(map)

        refute Map.has_key?(user, "something_strange")
        refute Map.has_key?(user, :something_strange)
      end
    end
  end
end
