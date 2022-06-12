class BackupJob < ApplicationJob
  queue_as :default

  def perform
    BackupArticles.new('local').backup
  end
end
