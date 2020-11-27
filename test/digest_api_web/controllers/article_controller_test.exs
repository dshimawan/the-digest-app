defmodule DigestApiWeb.ArticleControllerTest do
  use DigestApiWeb.ConnCase

  alias DigestApi.Repository
  alias DigestApi.Repository.Article

  @create_attrs %{
    author: "some author",
    content: "some content",
    description: "some description",
    img: "some img",
    pubTime: ~N[2010-04-17 14:00:00],
    source: "some source",
    title: "some title",
    topic: "some topic",
    url: "some url"
  }
  @update_attrs %{
    author: "some updated author",
    content: "some updated content",
    description: "some updated description",
    img: "some updated img",
    pubTime: ~N[2011-05-18 15:01:01],
    source: "some updated source",
    title: "some updated title",
    topic: "some updated topic",
    url: "some updated url"
  }
  @invalid_attrs %{author: nil, content: nil, description: nil, img: nil, pubTime: nil, source: nil, title: nil, topic: nil, url: nil}

  def fixture(:article) do
    {:ok, article} = Repository.create_article(@create_attrs)
    article
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all articles", %{conn: conn} do
      conn = get(conn, Routes.article_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create article" do
    test "renders article when data is valid", %{conn: conn} do
      conn = post(conn, Routes.article_path(conn, :create), article: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.article_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some author",
               "content" => "some content",
               "description" => "some description",
               "img" => "some img",
               "pubTime" => "2010-04-17T14:00:00",
               "source" => "some source",
               "title" => "some title",
               "topic" => "some topic",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.article_path(conn, :create), article: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update article" do
    setup [:create_article]

    test "renders article when data is valid", %{conn: conn, article: %Article{id: id} = article} do
      conn = put(conn, Routes.article_path(conn, :update, article), article: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.article_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some updated author",
               "content" => "some updated content",
               "description" => "some updated description",
               "img" => "some updated img",
               "pubTime" => "2011-05-18T15:01:01",
               "source" => "some updated source",
               "title" => "some updated title",
               "topic" => "some updated topic",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, article: article} do
      conn = put(conn, Routes.article_path(conn, :update, article), article: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete article" do
    setup [:create_article]

    test "deletes chosen article", %{conn: conn, article: article} do
      conn = delete(conn, Routes.article_path(conn, :delete, article))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.article_path(conn, :show, article))
      end
    end
  end

  defp create_article(_) do
    article = fixture(:article)
    %{article: article}
  end
end
