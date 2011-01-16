source 'http://rubygems.org'

gem "thin"
gem "rack"
gem "sinatra"
gem "sinatra-reloader"
gem "nokogiri"
gem "json"
gem "newrelic_rpm"

# async wrappers
gem 'eventmachine'
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony', :require => [
  'em-synchrony',
  'em-synchrony/em-http'
  ]

# async http requires
gem 'em-http-request', :require => 'em-http'
gem 'addressable', :require => 'addressable/uri'



group :test do
  gem "rack-test"
  gem "rspec"
  gem "fakeweb"
  gem 'autotest'
  gem 'autotest-fsevent'
  gem 'autotest-growl'
end