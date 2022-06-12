require 'rufus-scheduler'

return if defined?(Rails::Console) || Rails.env.test? || File.split($PROGRAM_NAME).last == 'rake'
return if $PROGRAM_NAME.include?('spring')

s = Rufus::Scheduler.singleton

s.cron '59 23 * * 0' do
  Rails.logger.info "Executing schedulled jobs at #{Time.now}"
  BackupJob.perform_later
  Rails.logger.flush
end
