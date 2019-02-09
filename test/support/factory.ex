defmodule Fyyd.Factory do
  @moduledoc false

  require ExUnitProperties

  alias Fyyd.Curations.Curation
  alias Fyyd.User

  @tlds ~w(.com .org .de .io .us .net)

  @image_base "https://img-1.fyyd.de"
  @user_image @image_base <> "/user"
  @curation_image @image_base <> "/curation"
  @collection_image @image_base <> "/collection"

  @feeds_base "https://feeds.fyyd.de"
  @user_base "https://fyyd.de/user"
  @episode_base "https://fyyd.de/episode"

  def non_empty_string do
    StreamData.string(:alphanumeric, min_length: 1)
  end

  def user_map do
    ExUnitProperties.gen all id <- StreamData.positive_integer(),
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
        "layoutImageURL" =>
          @user_image <> "/layout/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "thumbImageURL" => @user_image <> "/micro/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "microImageURL" => @user_image <> "/thumbs/" <> Integer.to_string(id) <> ".png?et=" <> et
      }
    end
  end

  def curation_map do
    ExUnitProperties.gen all id <- StreamData.positive_integer(),
                             title <- non_empty_string(),
                             description <- non_empty_string(),
                             public <- StreamData.integer(0..1),
                             type <- StreamData.positive_integer(),
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
        "url" => @user_base <> "/" <> nick <> "/curations/" <> slug,
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

  def curation_map_with_episodes do
    ExUnitProperties.gen all id <- StreamData.positive_integer(),
                             title <- non_empty_string(),
                             description <- non_empty_string(),
                             public <- StreamData.integer(0..1),
                             type <- StreamData.positive_integer(),
                             slug <- non_empty_string(),
                             episodes <- StreamData.uniq_list_of(episode_map(), max_length: 5),
                             nick <- non_empty_string(),
                             et <- non_empty_string() do
      %{
        "id" => id,
        "title" => title,
        "description" => description,
        "public" => public,
        "type" => type,
        "slug" => slug,
        "episodes" => episodes,
        "url" => @user_base <> "/" <> nick <> "/curations/" <> slug,
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

  def collection_map do
    ExUnitProperties.gen all id <- StreamData.positive_integer(),
                             user_id <- StreamData.positive_integer(),
                             title <- non_empty_string(),
                             description <- non_empty_string(),
                             slug <- non_empty_string(),
                             nick <- non_empty_string(),
                             et <- non_empty_string() do
      %{
        "id" => id,
        "user_id" => user_id,
        "title" => title,
        "description" => description,
        "slug" => slug,
        "url" => @user_base <> "/" <> nick <> "/collection/" <> slug,
        "layoutImageURL" =>
          @collection_image <> "/layout/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "smallImageURL" =>
          @collection_image <> "/small/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "thumbImageURL" =>
          @collection_image <> "/thumb/" <> Integer.to_string(id) <> ".png?et=" <> et,
        "microImageURL" =>
          @collection_image <> "/micro/" <> Integer.to_string(id) <> ".png?et=" <> et
      }
    end
  end

  def episode_map do
    ExUnitProperties.gen all id <- StreamData.positive_integer(),
                             guid <- non_empty_string(),
                             title <- non_empty_string(),
                             url <- non_empty_string(),
                             enclosure <- non_empty_string(),
                             podcast_id <- StreamData.positive_integer(),
                             duration <- StreamData.positive_integer(),
                             description <- non_empty_string(),
                             tld <- StreamData.member_of(@tlds) do
      %{
        "id" => id,
        "guid" => guid,
        "title" => title,
        "url" => "https://" <> url <> tld,
        "enclosure" => "https://" <> enclosure <> tld <> "/file.mp3",
        "podcast_id" => podcast_id,
        "imgURL" => "https://" <> enclosure <> tld <> "/image.jpg",
        "pubdate" => Timex.now() |> Timex.format!("{ISO:Extended}"),
        "duration" => duration,
        "url_fyyd" => @episode_base <> "/" <> Integer.to_string(id),
        "description" => description
      }
    end
  end

  def podcast_map do
    ExUnitProperties.gen all id <- StreamData.positive_integer(),
                             description <- non_empty_string(),
                             episode_count <- StreamData.positive_integer(),
                             etag <- non_empty_string(),
                             generator <- non_empty_string(),
                             htmlURL <- non_empty_string(),
                             imgURL <- non_empty_string(),
                             language <- non_empty_string(),
                             lastmodified <- non_empty_string(),
                             lastpoll <- non_empty_string(),
                             lastpub <- non_empty_string(),
                             layoutImageURL <- non_empty_string(),
                             md5body <- non_empty_string(),
                             microImageURL <- non_empty_string(),
                             rank <- StreamData.positive_integer(),
                             slug <- non_empty_string(),
                             smallImageURL <- non_empty_string(),
                             status <- StreamData.positive_integer(),
                             subtitle <- non_empty_string(),
                             thumbImageURL <- non_empty_string(),
                             title <- non_empty_string(),
                             url_fyyd <- non_empty_string(),
                             xmlUrl <- non_empty_string() do
      %{
        "id" => id,
        "description" => description,
        "episode_count" => episode_count,
        "etag" => etag,
        "generator" => generator,
        "htmlURL" => htmlURL,
        "imgURL" => imgURL,
        "language" => language,
        "lastmodified" => lastmodified,
        "lastpoll" => lastpoll,
        "lastpub" => lastpub,
        "layoutImageURL" => layoutImageURL,
        "md5body" => md5body,
        "microImageURL" => microImageURL,
        "rank" => rank,
        "slug" => slug,
        "smallImageURL" => smallImageURL,
        "status" => status,
        "subtitle" => subtitle,
        "thumbImageURL" => thumbImageURL,
        "title" => title,
        "url_fyyd" => url_fyyd,
        "xmlUrl" => xmlUrl
      }
    end
  end

  def account_map do
    ExUnitProperties.gen all id <- StreamData.positive_integer(),
                             fullname <- non_empty_string(),
                             bio <- non_empty_string(),
                             nick <- non_empty_string(),
                             url <- non_empty_string(),
                             layoutImageURL <- non_empty_string(),
                             microImageURL <- non_empty_string(),
                             smallImageURL <- non_empty_string(),
                             thumbImageURL <- non_empty_string() do
      %{
        "id" => id,
        "fullname" => fullname,
        "bio" => bio,
        "nick" => nick,
        "url" => url,
        "layoutImageURL" => layoutImageURL,
        "microImageURL" => microImageURL,
        "smallImageURL" => smallImageURL,
        "thumbImageURL" => thumbImageURL
      }
    end
  end

  def category_map_without_subs do
    ExUnitProperties.gen all base_category <- base_category_map() do
      Map.put_new(base_category, "subcategories", [])
    end
  end

  def category_map_with_subs do
    ExUnitProperties.gen all base_category <- base_category_map(),
                             subcategories <- StreamData.uniq_list_of(base_category_map()) do
      Map.put_new(base_category, "subcategories", subcategories)
    end
  end

  def base_category_map do
    ExUnitProperties.gen all id <- StreamData.positive_integer(),
                             name <- non_empty_string(),
                             name_de <- non_empty_string(),
                             slug <- non_empty_string() do
      %{
        "id" => id,
        "name" => name,
        "name_de" => name_de,
        "slug" => slug
      }
    end
  end

  # ---------------------------------------- Hardcoded Test Values
  def optikfluffel do
    %User{
      bio: "Just looking around.",
      fullname: "optikfluffel",
      id: 2078,
      layoutImageURL: @user_image <> "/layout/2078.jpg?et=644a12a72e1f75f671ede648850a0b98",
      microImageURL: @user_image <> "/micro/2078.png?et=644a12a72e1f75f671ede648850a0b98",
      nick: "optikfluffel",
      thumbImageURL: @user_image <> "/thumbs/2078.png?et=644a12a72e1f75f671ede648850a0b98",
      url: "https://www.instagram.com/optikfluffel/"
    }
  end

  def public_test_curation do
    %Curation{
      description: "public test feed for optikfluffel",
      id: 2087,
      layoutImageURL: @curation_image <> "/layout/2087.jpg?et=9408c6befe81e94f3b6899c0b9b12041",
      microImageURL: @curation_image <> "/micro/2087.png?et=9408c6befe81e94f3b6899c0b9b12041",
      public: 1,
      slug: "6d9d617d6febc168b11fc630f5435d1b",
      thumbImageURL: @curation_image <> "/thumbs/2087.png?et=9408c6befe81e94f3b6899c0b9b12041",
      title: "test curation for optikfluffel",
      type: 1,
      url: "https://fyyd.de/user/optikfluffel/curation/6d9d617d6febc168b11fc630f5435d1b",
      xmlURL: "https://feeds.fyyd.de/optikfluffel/6d9d617d6febc168b11fc630f5435d1b"
    }
  end

  def public_test_collection do
    %Fyyd.Collections.Collection{
      description: "mainly for testing https://github.com/optikfluffel/fyyd_ex",
      id: 784,
      layoutImageURL: @collection_image <> "/layout/784.jpg?et=a252ee89acfbfb45ee9cb784a5b751eb",
      microImageURL: @collection_image <> "/micro/784.png?et=a252ee89acfbfb45ee9cb784a5b751eb",
      slug: "ee749d2f70420454714c01ee524a232e",
      smallImageURL: @collection_image <> "/small/784.jpg?et=a252ee89acfbfb45ee9cb784a5b751eb",
      thumbImageURL: @collection_image <> "/thumbs/784.png?et=a252ee89acfbfb45ee9cb784a5b751eb",
      title: "public test collection",
      url: "https://api.fyyd.de/user/optikfluffel/collection/ee749d2f70420454714c01ee524a232e",
      user_id: 2078
    }
  end
end
