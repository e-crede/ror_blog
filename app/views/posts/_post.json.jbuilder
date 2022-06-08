json.extract! post, :id, :title, :slug, :content, :views, :created_at, :updated_at
json.url post_url(post, format: :json)
