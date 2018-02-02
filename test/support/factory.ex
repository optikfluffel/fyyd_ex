defmodule Fyyd.Factory do
  @moduledoc false

  require ExUnitProperties

  alias Fyyd.Curations.Curation
  alias Fyyd.User

  @tlds ~w(.com .org .de .io .us .net)

  @image_base "https://img.fyyd.de"
  @user_image @image_base <> "/user"
  @curation_image @image_base <> "/curation"

  @feeds_base "https://feeds.fyyd.de"
  @user_base "https://fyyd.de/user"

  def non_empty_string do
    :alphanumeric
    |> StreamData.string()
    |> StreamData.filter(&(&1 != ""))
  end

  def user_map do
    ExUnitProperties.gen all id <- StreamData.integer(),
                             nick <- non_empty_string(),
                             bio <- non_empty_string(),
                             url <- non_empty_string(),
                             et <- non_empty_string(),
                             tld <- StreamData.member_of(@tlds) do
      %{
        "id" => id,
        "nick" => nick,
        "fullname" => "Fullname " <> nick,
        "bio" => bio,
        "url" => "https://" <> url <> tld,
        "layoutImageURL" => @user_image <> "/layout/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "thumbImageURL" => @user_image <> "/micro/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "microImageURL" => @user_image <> "/thumbs/" <> Integer.to_string(id) <> ".png?et=" <> et
      }
    end
  end

  def curation_map do
    ExUnitProperties.gen all id <- StreamData.integer(),
                             title <- non_empty_string(),
                             description <- non_empty_string(),
                             public <- StreamData.integer(0..1),
                             type <- StreamData.integer(),
                             slug <- non_empty_string(),
                             nick <- non_empty_string(),
                             et <- non_empty_string() do
      %{
        "id" => id,
        "title" => title,
        "description" => description,
        "public" => public,
        "type" => type,
        "slug" => slug,
        "url" => @user_base <> "/" <> nick <> "/curation/" <> slug,
        "xmlURL" => @feeds_base <> "/" <> nick <> "/" <> slug,
        "layoutImageURL" =>
          @curation_image <> "/layout/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "thumbImageURL" =>
          @curation_image <> "/thumb/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "microImageURL" =>
          @curation_image <> "/micro/" <> Integer.to_string(id) <> ".png?et=" <> et
      }
    end
  end

  # ---------------------------------------- Hardcoded Test Values
  def optikfluffel do
    %User{
      bio: "Just looking around.",
      fullname: "optikfluffel",
      id: 2078,
      layoutImageURL:
        "https://img.fyyd.de/user/layout/2078.jpg?et=644a12a72e1f75f671ede648850a0b98",
      microImageURL: "https://img.fyyd.de/user/micro/2078.png?et=644a12a72e1f75f671ede648850a0b98",
      nick: "optikfluffel",
      thumbImageURL:
        "https://img.fyyd.de/user/thumbs/2078.png?et=644a12a72e1f75f671ede648850a0b98",
      url: "https://www.instagram.com/optikfluffel/"
    }
  end

  def public_test_curation do
    %Curation{
      description: "public test feed for optikfluffel",
      id: 2087,
      layoutImageURL:
        "https://img.fyyd.de/curation/layout/2087.jpg?et=9408c6befe81e94f3b6899c0b9b12041",
      microImageURL:
        "https://img.fyyd.de/curation/micro/2087.png?et=9408c6befe81e94f3b6899c0b9b12041",
      public: 1,
      slug: "6d9d617d6febc168b11fc630f5435d1b",
      thumbImageURL:
        "https://img.fyyd.de/curation/thumbs/2087.png?et=9408c6befe81e94f3b6899c0b9b12041",
      title: "test curation for optikfluffel",
      type: 1,
      url: "https://fyyd.de/user/optikfluffel/curation/6d9d617d6febc168b11fc630f5435d1b",
      xmlURL: "https://feeds.fyyd.de/optikfluffel/6d9d617d6febc168b11fc630f5435d1b"
    }
  end
end
