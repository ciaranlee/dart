require 'dart.rb'

require 'rubygems'

require "bundler"
Bundler.setup

require 'rack'
require 'sinatra'

run Sinatra::Application