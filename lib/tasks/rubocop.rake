# rubocop:disable Lint/HandleExceptions
begin
  require 'rubocop/rake_task'

  desc 'Run rubocop'
  task :rubocop do
    RuboCop::RakeTask.new
  end
rescue LoadError
  # We're fine, this is to be expected in production & staging.
end
# rubocop:enable Lint/HandleExceptions
