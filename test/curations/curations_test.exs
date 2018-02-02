defmodule Fyyd.CurationsTest do
  @moduledoc false

  use ExUnit.Case, async: false
  use ExUnitProperties
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Fyyd.Curations
  alias Fyyd.Curations.Curation
  alias Fyyd.Factory

  doctest Curations

  setup_all do
    HTTPoison.start()
  end

  describe "get_for_user/1" do
    test "gets Curations for a given User by it's id" do
      use_cassette "curations_user_id" do
        {:ok, curations} = Curations.get_for_user(Factory.optikfluffel().id)

        assert %Curation{} = List.first(curations)
        assert Enum.member?(curations, Factory.public_test_curation())
      end
    end

    test "gets Curations for a given User by it's id, where id is a string" do
      use_cassette "curations_user_id" do
        {:ok, curations} =
          Factory.optikfluffel().id
          |> Integer.to_string()
          |> Curations.get_for_user()

        assert %Curation{} = List.first(curations)
        assert Enum.member?(curations, Factory.public_test_curation())
      end
    end
  end

  describe "get_for_user_by_nick/1" do
    test "gets Curations for a given User by it's nick" do
      use_cassette "curations_user_nick" do
        assert {:ok, curations} = Curations.get_for_user_by_nick(Factory.optikfluffel().nick)

        assert %Curation{} = List.first(curations)
        assert Enum.member?(curations, Factory.public_test_curation())
      end
    end
  end

  describe "extract_curations_from_response/1" do
    test "converts a list of valid maps to a List of %Curations{}" do
      {:ok, curations} =
        Factory.curation_map()
        |> Enum.take(:rand.uniform(100))
        |> Curations.extract_curations_from_response()

      assert %Curation{} = List.first(curations)
    end

    test "works with an empty list" do
      assert {:ok, []} = Curations.extract_curations_from_response([])
    end
  end
end
