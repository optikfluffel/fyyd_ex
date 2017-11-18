defmodule Fyyd.API.Response do
  @moduledoc false

  @derive [Poison.Encoder]

  defstruct [:status, :msg, :meta, :data]
end

defmodule Fyyd.API.Response.Meta do
  @moduledoc false

  @derive [Poison.Encoder]

  defstruct [:API_INFO]
end

defmodule Fyyd.API.Response.APIInfo do
  @moduledoc false

  @derive [Poison.Encoder]

  defstruct [:API_VERSION]
end
