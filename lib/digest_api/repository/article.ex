defmodule DigestApi.Repository.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :author, :string
    field :content, :string
    field :description, :string
    field :img, :string
    field :pubTime, :naive_datetime
    field :source, :string
    field :title, :string
    field :topic, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :topic, :source, :author, :description, :url, :img, :pubTime, :content])
    |> validate_required([:title, :topic, :source, :author, :description, :url, :img, :pubTime, :content])
  end
end
