defmodule Fyyd.APITest do
  @moduledoc false

  use ExUnit.Case, async: false
  use ExUnitProperties
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Fyyd.API

  @base_url_with_version "https://api.fyyd.de/0.2"

  doctest API

  setup_all do
    HTTPoison.start()
  end

  property "process_url/1 results always start with base_url followed by version" do
    check all string <- StreamData.string(:alphanumeric) do
      assert string
             |> API.process_url()
             |> String.starts_with?(@base_url_with_version)
    end
  end

  describe "get_data/1" do
    test "returns error when given a non existing url" do
      use_cassette "api_non_existing" do
        assert {:error, :not_found} = API.get_data("/nothing/to/be/found/here")
      end
    end
  end
end
