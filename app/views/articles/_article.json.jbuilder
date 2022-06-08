json.extract! article, :id, :title, :slug, :content, :views, :created_at, :updated_at
json.url article_url(article, format: :json)
