task :jobs do
  puts 'Clearing Delayed Jobs'
  system "rake jobs:clear"
  puts 'Running Delayed Jobs Server'
  system "rake jobs:work"
end