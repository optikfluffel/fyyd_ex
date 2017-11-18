defmodule Fyyd.APITest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  doctest Fyyd.API

  @base_url_with_version "https://api.fyyd.de/0.2"

  property "process_url/1 results always start with base_url followed by version" do
    check all string <- StreamData.string(:alphanumeric) do
      assert string
      |> Fyyd.API.process_url()
      |> String.starts_with?(@base_url_with_version)
    end
  end
end
