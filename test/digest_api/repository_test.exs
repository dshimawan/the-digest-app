defmodule DigestApi.RepositoryTest do
  use DigestApi.DataCase

  alias DigestApi.Repository

  describe "articles" do
    alias DigestApi.Repository.Article

    @valid_attrs %{author: "some author", content: "some content", description: "some description", img: "some img", pubTime: ~N[2010-04-17 14:00:00], source: "some source", title: "some title", topic: "some topic", url: "some url"}
    @update_attrs %{author: "some updated author", content: "some updated content", description: "some updated description", img: "some updated img", pubTime: ~N[2011-05-18 15:01:01], source: "some updated source", title: "some updated title", topic: "some updated topic", url: "some updated url"}
    @invalid_attrs %{author: nil, content: nil, description: nil, img: nil, pubTime: nil, source: nil, title: nil, topic: nil, url: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Repository.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Repository.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Repository.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Repository.create_article(@valid_attrs)
      assert article.author == "some author"
      assert article.content == "some content"
      assert article.description == "some description"
      assert article.img == "some img"
      assert article.pubTime == ~N[2010-04-17 14:00:00]
      assert article.source == "some source"
      assert article.title == "some title"
      assert article.topic == "some topic"
      assert article.url == "some url"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Repository.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Repository.update_article(article, @update_attrs)
      assert article.author == "some updated author"
      assert article.content == "some updated content"
      assert article.description == "some updated description"
      assert article.img == "some updated img"
      assert article.pubTime == ~N[2011-05-18 15:01:01]
      assert article.source == "some updated source"
      assert article.title == "some updated title"
      assert article.topic == "some updated topic"
      assert article.url == "some updated url"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Repository.update_article(article, @invalid_attrs)
      assert article == Repository.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Repository.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Repository.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Repository.change_article(article)
    end
  end
end
