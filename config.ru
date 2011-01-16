require File.join(File.dirname(__FILE__), 'dart.rb')
require 'rack/fiber_pool'
use Rack::FiberPool
run Sinatra::Application