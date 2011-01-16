# coding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe 'Dart' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context '/results.json' do

    before(:all) { get '/results.json?station=Seapoint' }

    context "basics" do
      subject { last_response }
      its(:status) {should == 200}
      its(:content_type) {should == 'application/json;charset=utf-8'}
    end

    context "complexities" do
      subject { JSON.parse(last_response.body) }
      it { should == {
                      'results' => [
                        {
                          'direction'=>'Northbound',
                          'trains'=> [
                            {'route'=>' Bray to Malahide(E813)', 'service'=>'DART', 'scheduled'=>'12:33', 'eta'=>'12:33', 'due'=>'6 Mins', 'info'=>' Arrived Sandycove'},
                            {'route'=>' Bray to Howth(E915)', 'service'=>'DART', 'scheduled'=>'12:48', 'eta'=>'12:49', 'due'=>'22 Mins', 'info'=>' Departed Bray'},
                            {'route'=>' Greystones to Howth(E947)', 'service'=>'DART', 'scheduled'=>'13:03', 'eta'=>'13:03', 'due'=>'36 Mins', 'info'=>'  '},
                            {'route'=>' Bray to Howth(E916)', 'service'=>'DART', 'scheduled'=>'13:18', 'eta'=>'13:18', 'due'=>'51 Mins', 'info'=>'  '}
                          ]
                        },
                        {
                          'direction'=>'Southbound',
                          'trains'=> [
                            {'route'=>' Howth to Bray(E212)', 'service'=>'DART', 'scheduled'=>'12:29', 'eta'=>'12:32', 'due'=>'5 Mins', 'info'=>' Departed Sydney Parade'},
                            {'route'=>' Malahide to Greystones(E112)', 'service'=>'DART', 'scheduled'=>'12:44', 'eta'=>'12:45', 'due'=>'18 Mins', 'info'=>' Departed Dublin Connolly'},
                            {'route'=>' Howth to Bray(E213)', 'service'=>'DART', 'scheduled'=>'12:59', 'eta'=>'12:59', 'due'=>'32 Mins', 'info'=>' Arrived Kilbarrack'},
                            {'route'=>' Malahide to Bray(E245)', 'service'=>'DART', 'scheduled'=>'13:14', 'eta'=>'13:14', 'due'=>'47 Mins', 'info'=>'  '}
                          ],
                        }
                      ]
                    }
      }
    end

  end

end