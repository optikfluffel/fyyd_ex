defmodule FyydTest do
  @moduledoc false

  use ExUnit.Case, async: true

  doctest Fyyd

  test "greets the world" do
    assert Fyyd.hello() == :world
  end
end
