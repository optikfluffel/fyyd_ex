defmodule FyydTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Fyyd.Factory
  alias Fyyd.Curations.Curation
  alias Fyyd.Episodes.Episode
  alias Fyyd.Collections.Collection
  alias Fyyd.Podcasts.Podcast

  setup_all do
    HTTPoison.start()
  end

  describe "user/1" do
    test "gets a User by it's id" do
      use_cassette "user_id" do
        known_user = Factory.optikfluffel()

        assert {:ok, ^known_user} = Fyyd.user(known_user.id)
      end
    end

    test "gets a User by it's id, where id is a string" do
      use_cassette "user_id" do
        known_user = Factory.optikfluffel()

        assert {:ok, ^known_user} =
                 known_user.id
                 |> Integer.to_string()
                 |> Fyyd.user()
      end
    end
  end

  describe "user_by_nick/1" do
    test "gets a User by it's nick" do
      use_cassette "user_nick" do
        known_user = Factory.optikfluffel()

        assert {:ok, ^known_user} = Fyyd.user_by_nick(known_user.nick)
      end
    end
  end

  describe "curations_for_user/1" do
    test "gets Curations for a given User by it's id" do
      use_cassette "curations_user_id" do
        {:ok, curations} = Fyyd.curations_for_user(Factory.optikfluffel().id)

        assert %Curation{} = List.first(curations)
        assert Enum.member?(curations, Factory.public_test_curation())
      end
    end

    test "gets Curations for a given User by it's id, where id is a string" do
      use_cassette "curations_user_id" do
        {:ok, curations} =
          Factory.optikfluffel().id
          |> Integer.to_string()
          |> Fyyd.curations_for_user()

        assert %Curation{} = List.first(curations)
        assert Enum.member?(curations, Factory.public_test_curation())
      end
    end

    test "gets Curations for a given User  by it's id, including Episodes" do
      use_cassette "curations_user_id_include_episodes" do
        {:ok, curations} = Fyyd.curations_for_user(Factory.optikfluffel().id, include: :episodes)

        assert %Curation{} = curation = List.first(curations)
        assert %Episode{} = List.first(curation.episodes)
      end
    end
  end

  describe "curations_for_user_by_nick/1" do
    test "gets Curations for a given User by it's nick" do
      use_cassette "curations_user_nick" do
        assert {:ok, curations} = Fyyd.curations_for_user_by_nick(Factory.optikfluffel().nick)

        assert %Curation{} = List.first(curations)
        assert Enum.member?(curations, Factory.public_test_curation())
      end
    end

    test "gets Curations for a given User by it's nick, including Episodes" do
      use_cassette "curations_user_nick_include_episodes" do
        assert {:ok, curations} =
                 Fyyd.curations_for_user_by_nick(Factory.optikfluffel().nick, include: :episodes)

        assert %Curation{} = curation = List.first(curations)
        assert %Episode{} = List.first(curation.episodes)
      end
    end
  end

  describe "collections_for_user/1" do
    test "gets Collections for a given User by it's id" do
      use_cassette "collections_user_id" do
        {:ok, collections} = Fyyd.collections_for_user(Factory.optikfluffel().id)

        assert %Collection{} = List.first(collections)
        assert Enum.member?(collections, Factory.public_test_collection())
      end
    end

    test "gets Collections for a given User by it's id, where id is a string" do
      use_cassette "collections_user_id" do
        {:ok, collections} =
          Factory.optikfluffel().id
          |> Integer.to_string()
          |> Fyyd.collections_for_user()

        assert %Collection{} = List.first(collections)
        assert Enum.member?(collections, Factory.public_test_collection())
      end
    end

    test "gets Collections for a given User  by it's id, including Podcasts" do
      use_cassette "collections_user_id_include_podcasts" do
        {:ok, collections} =
          Fyyd.collections_for_user(Factory.optikfluffel().id, include: :podcasts)

        assert %Collection{} = collection = List.first(collections)
        assert %Podcast{} = List.first(collection.podcasts)
      end
    end
  end

  describe "collections_for_user_by_nick/1" do
    test "gets Collections for a given User by it's nick" do
      use_cassette "collections_user_nick" do
        assert {:ok, collections} = Fyyd.collections_for_user_by_nick(Factory.optikfluffel().nick)

        assert %Collection{} = List.first(collections)
        assert Enum.member?(collections, Factory.public_test_collection())
      end
    end

    test "gets Collection for a given User by it's nick, including Podcasts" do
      use_cassette "collections_user_nick_include_podcasts" do
        assert {:ok, collections} =
                 Fyyd.collections_for_user_by_nick(
                   Factory.optikfluffel().nick,
                   include: :podcasts
                 )

        assert %Collection{} = collection = List.first(collections)
        assert %Podcast{} = List.first(collection.podcasts)
      end
    end
  end
end
