class DisplayController < ApplicationController
  
  def index
    @articles = Article.all
  end
end
