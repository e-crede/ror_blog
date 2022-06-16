class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show_by_slug ]
  before_action :set_article_by_slug, only: %i[ show_by_slug ]
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    markdown = init_markdown
    @article[:content_html] = markdown.render(@article[:content_md])
    @article[:slug] = generate_slug(@article)
    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      # @article[:content_html] = markdown.render(@article[:content_md])
      if @article.update(article_params)
        markdown = init_markdown
        @article.update(content_html: markdown.render(@article[:content_md]))
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def show_by_slug
    render 'show'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def set_article_by_slug
    @article = Article.find_by(slug: params[:slug])
  end

  # Generates a slug from title
  # Uniq constraint checked within model
  def generate_slug(article)
    return article.slug unless article.slug.empty?

    article.title.force_encoding('ascii').gsub(' ', '-').downcase
  end

  def article_params
    params.require(:article).permit(:title, :slug, :content_md, :views, :published, :show_in_feed, :brief, :image, :category)
  end

  def init_markdown
    extensions = { no_intra_emphasis: true, fenced_code_blocks: true, disable_indented_code_blocks: true, strikethrough: true, lax_spacing: true, superscript: true, highlight: true, quote: true, footnotes: true, autolink: true, tables: true}
    red_html = Redcarpet::Render::HTML.new( { filter_html: false } )
    Redcarpet::Markdown.new(red_html, extensions)
  end
end
