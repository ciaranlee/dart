require File.dirname(__FILE__) + '/spec_helper'

describe 'MyApp' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should run a simple test' do
    get '/'
    last_response.status.should == 200
    # last_response.status.should == 201  
  end
end