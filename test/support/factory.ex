defmodule Fyyd.Factory do
  @moduledoc false

  require ExUnitProperties

  alias Fyyd.User

  @tlds ~w(.com .org .de .io .us .net)
  @base_image_url "https://img.fyyd.de/user"

  def user_map do
    ExUnitProperties.gen all id <- StreamData.integer(),
                             nick <- StreamData.string(:alphanumeric),
                             nick != "",
                             bio <- StreamData.string(:alphanumeric),
                             bio != "",
                             url <- StreamData.string(:alphanumeric),
                             url != "",
                             et <- StreamData.string(:alphanumeric),
                             et != "",
                             tld <- StreamData.member_of(@tlds) do
      %{
        "id"             => id,
        "nick"           => nick,
        "fullname"       => "Fullname " <> nick,
        "bio"            => bio,
        "url"            => "https://" <> url <> tld,
        "layoutImageURL" => @base_image_url <> "/layout/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "thumbImageURL"  => @base_image_url <> "/micro/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "microImageURL"  => @base_image_url <> "/thumbs/" <> Integer.to_string(id) <> ".png?et=" <> et
      }
    end
  end

  # ---------------------------------------- Hardcoded Test Values
  def optikfluffel do
    %User{
      bio: "Just looking around.",
      fullname: "optikfluffel",
      id: 2078,
      layoutImageURL: "https://img.fyyd.de/user/layout/2078.jpg?et=644a12a72e1f75f671ede648850a0b98",
      microImageURL: "https://img.fyyd.de/user/micro/2078.png?et=644a12a72e1f75f671ede648850a0b98",
      nick: "optikfluffel",
      thumbImageURL: "https://img.fyyd.de/user/thumbs/2078.png?et=644a12a72e1f75f671ede648850a0b98",
      url: "https://www.instagram.com/optikfluffel/"
    }
  end
end
