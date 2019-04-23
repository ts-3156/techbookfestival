require 'dotenv/load'
require "active_record"

# debugging
ActiveRecord::Base.logger = Logger.new(STDOUT).tap {|l| l.level = Logger::INFO}

yaml = <<"YAML"
dev:
  adapter: mysql2
  encoding: utf8mb4
  charset: utf8mb4
  collation: utf8mb4_unicode_ci
  database: techbookfestival
  pool: 5
  username: root
  password: #{ENV['PASS']}
  host: localhost
YAML

# migrations
ActiveRecord::Base.establish_connection(YAML.load(yaml)['dev'])
