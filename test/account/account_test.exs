defmodule Fyyd.AccountTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Fyyd.Account
  alias Fyyd.Factory

  describe "extract_from_response/1" do
    property "converts a valid map to a %Account{}" do
      check all map <- Factory.account_map() do
        map_id = map["id"]

        assert {:ok, %Account{id: ^map_id}} = Account.extract_from_response(map)
      end
    end
  end
end
