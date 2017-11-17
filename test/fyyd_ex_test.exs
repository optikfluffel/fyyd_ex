defmodule FyydExTest do
  @moduledoc false

  use ExUnit.Case
  doctest FyydEx

  test "greets the world" do
    assert FyydEx.hello() == :world
  end
end
