require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'


set :database, "sqlite3:microblog.sqlite3"