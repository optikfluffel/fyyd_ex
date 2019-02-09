defmodule Fyyd.Episodes.Episode do
  @moduledoc false

  alias Fyyd.Utils

  @fields ~w(id guid title url enclosure podcast_id imgURL
                      pubdate duration url_fyyd description)a

  defstruct @fields

  @type t :: %__MODULE__{
          id: integer,
          guid: String.t(),
          title: String.t(),
          url: String.t(),
          enclosure: String.t(),
          podcast_id: integer,
          imgURL: String.t(),
          pubdate: String.t(),
          duration: integer,
          url_fyyd: String.t(),
          description: String.t()
        }

  @doc false
  @spec extract_from_response(map) :: {:ok, t}
  def extract_from_response(data) do
    episode =
      data
      |> Utils.extract_from_response(@fields)
      |> Utils.struct_from_keyword_list(__MODULE__)

    {:ok, episode}
  end
end
