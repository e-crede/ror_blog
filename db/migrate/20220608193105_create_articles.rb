class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.string :brief
      t.string :content_md
      t.string :content_html
      t.integer :views
      t.boolean :published, default: false, null: false
      t.boolean :show_in_feed, default: false, null: false
      t.timestamps
    end
  end
end
