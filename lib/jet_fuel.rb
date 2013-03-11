require 'active_record'
require 'shotgun'
require 'sinatra'
require 'logger'
require 'yaml'

require './db/migrate/001_create_urls'
require './lib/url'