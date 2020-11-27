defmodule DigestApiWeb.ArticleView do
  use DigestApiWeb, :view
  alias DigestApiWeb.ArticleView

  def render("index.json", %{articles: articles}) do
    %{data: render_many(articles, ArticleView, "article.json")}
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, ArticleView, "article.json")}
  end

  def render("article.json", %{article: article}) do
    %{id: article.id,
      title: article.title,
      topic: article.topic,
      source: article.source,
      author: article.author,
      description: article.description,
      url: article.url,
      img: article.img,
      pubTime: article.pubTime,
      content: article.content}
  end
end
