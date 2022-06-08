class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.string :content
      t.integer :views
      t.boolean :published, default: false, null: false
      t.timestamps
    end
  end
end
