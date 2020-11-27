defmodule DigestApi.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :topic, :string
      add :source, :string
      add :author, :string
      add :description, :text
      add :url, :text
      add :img, :text
      add :pubTime, :naive_datetime
      add :content, :text

      timestamps()
    end

  end
end
