class BackupArticles
  def initialize(type = 'local')
    @type = type
    @tmp_dir = 'tmp/backup.gz'
  end

  def backup
    case @type
    when 'local' then to_local
    when 'email' then to_email
    else raise StandardError.new "Unknown backup type: #{@type}"
    end
  end

  private

  def to_local
    prepare_articles
  end

  def to_email
    prepare_articles
  end

  def prepare_articles
    Zlib::GzipWriter.open(@tmp_dir) do |file|
      file.write Article.all.to_json
    end
  end
end
