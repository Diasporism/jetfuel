require './lib/jet_fuel'

ENV['DB_ENV'] ||= 'development'


task :spec => :default do
  require './spec/spec_helper'
  RSpec::Core::RakeTask.new('spec')
end

task :default => :migrate

task :migrate => :environment do
  puts "Migrating database in the #{ENV['DB_ENV']} environment"

  if ENV['VERSION']
    ActiveRecord::Migrator.migrate('db/migrate', ENV['VERSION'].to_i)
  else

  end
end

task :environment do
  puts 'Loading my database environment'

  database_configuration = YAML::load(File.open('database.yml'))
  environment_configuration = database_configuration[ENV['DB_ENV']]

  ActiveRecord::Base.establish_connection environment_configuration
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end