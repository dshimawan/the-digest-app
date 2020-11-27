defmodule DigestApi.Repo.Migrations.ModifyArticlesMakeValueCi do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      modify :topic, :citext
      modify :source, :citext
    end
  end
end
