# coding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe 'Dart' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context '/results.json' do
    it 'should return a 200 result' do
      get '/results.json?station=Seapoint'
      last_response.status.should == 200
    end

    it 'should be formatted as JSON' do
      get '/results.json?station=Seapoint'
      last_response.content_type.should == 'application/json;charset=utf-8'
    end

    it 'should return a json structure' do
      get '/results.json?station=Seapoint'
      JSON.parse(last_response.body).should == {
        'results' => [
          {'direction'=>'Northbound', 'route'=>' Bray to Malahide(E813)', 'service'=>'DART', 'scheduled'=>'12:33', 'eta'=>'12:33', 'due'=>'6 Mins', 'info'=>' Arrived Sandycove'},
          {'direction'=>'Northbound', 'route'=>' Bray to Howth(E915)', 'service'=>'DART', 'scheduled'=>'12:48', 'eta'=>'12:49', 'due'=>'22 Mins', 'info'=>' Departed Bray'},
          {'direction'=>'Northbound', 'route'=>' Greystones to Howth(E947)', 'service'=>'DART', 'scheduled'=>'13:03', 'eta'=>'13:03', 'due'=>'36 Mins', 'info'=>'  '},
          {'direction'=>'Northbound', 'route'=>' Bray to Howth(E916)', 'service'=>'DART', 'scheduled'=>'13:18', 'eta'=>'13:18', 'due'=>'51 Mins', 'info'=>'  '},
          {'direction'=>'Southbound', 'route'=>' Howth to Bray(E212)', 'service'=>'DART', 'scheduled'=>'12:29', 'eta'=>'12:32', 'due'=>'5 Mins', 'info'=>' Departed Sydney Parade'},
          {'direction'=>'Southbound', 'route'=>' Malahide to Greystones(E112)', 'service'=>'DART', 'scheduled'=>'12:44', 'eta'=>'12:45', 'due'=>'18 Mins', 'info'=>' Departed Dublin Connolly'},
          {'direction'=>'Southbound', 'route'=>' Howth to Bray(E213)', 'service'=>'DART', 'scheduled'=>'12:59', 'eta'=>'12:59', 'due'=>'32 Mins', 'info'=>' Arrived Kilbarrack'},
          {'direction'=>'Southbound', 'route'=>' Malahide to Bray(E245)', 'service'=>'DART', 'scheduled'=>'13:14', 'eta'=>'13:14', 'due'=>'47 Mins', 'info'=>'  '}
        ]
      }
    end
  end

end