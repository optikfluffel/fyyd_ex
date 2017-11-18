defmodule Fyyd.Factory do
  @moduledoc false

  require ExUnitProperties

  @tlds ~w(.com .org .de .io .us .net)
  @base_image_url "https://img.fyyd.de/user"

  # id nick fullname bio url layoutImageURL thumbImageURL microImageURL
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
end
