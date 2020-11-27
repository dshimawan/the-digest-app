defmodule DigestApiWeb.ArticleController do
  use DigestApiWeb, :controller

  import Ecto.Query

  alias DigestApi.Repo
  alias DigestApi.Repository
  alias DigestApi.Repository.Article

  action_fallback DigestApiWeb.FallbackController

  def indexTopic(conn, %{"topic" => topic}) do
    IO.inspect conn.assigns.current_user
    articles = Repo.all(from t in Article, order_by: [desc: :pubTime], where: t.topic == ^topic, select: t)
    render(conn, "index.json", articles: articles)
  end

  def indexSource(conn, %{"source" => source}) do
    IO.inspect conn.assigns.current_user
    articles = Repo.all(from t in Article, order_by: [desc: :pubTime], where: t.source == ^source, select: t)
    render(conn, "index.json", articles: articles)
  end

  def index(conn, _params) do
    IO.inspect conn.assigns.current_user
    articles = Repository.list_articles()
    render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params}) do
    IO.inspect conn.assigns.current_user
    with {:ok, %Article{} = article} <- Repository.create_article(article_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.article_path(conn, :show, article))
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.inspect conn.assigns.current_user
    article = Repository.get_article!(id)
    render(conn, "show.json", article: article)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    IO.inspect conn.assigns.current_user
    article = Repository.get_article!(id)

    with {:ok, %Article{} = article} <- Repository.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  def delete(conn, %{"id" => id}) do
    IO.inspect conn.assigns.current_user
    article = Repository.get_article!(id)

    with {:ok, %Article{}} <- Repository.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
