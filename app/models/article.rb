class Article < ApplicationRecord
  validates :title, :brief, :content_md, presence: true
  validates :slug, uniqueness: { case_sensitive: false }
  enum :category, [ :general, :misc, :trips, :repairs ]
end
