class CreateArticleStorages < ActiveRecord::Migration
  def change
    create_table :article_storages do |t|
      t.references :article, index: true
      t.references :storage, index: true

      t.timestamps
    end
  end
end
