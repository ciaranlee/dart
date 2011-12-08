require 'rubygems'
require 'cgi'

require "bundler"
Bundler.setup

require 'rack'
require 'em-synchrony'
require 'em-synchrony/em-http'
require 'sinatra'
require "sinatra/reloader" if development?
require 'nokogiri'
require 'json'

configure :production do
  require 'newrelic_rpm'
end


set :public, File.dirname(__FILE__) + '/public'

get '/' do
  @stations = [
    { name:"Malahide", lat:53.45074, lng:-6.156477 },
    { name:"Portmarnock", lat:53.417592, lng:-6.151212 },
    { name:"Clongriffin", lat:53.402503, lng:-6.148975 },
    { name:"Howth", lat:53.389041, lng:-6.074203 },
    { name:"Sutton", lat:53.391962, lng:-6.116399 },
    { name:"Bayside", lat:53.391487, lng:-6.136861 },
    { name:"Howth Junction", lat:53.391429, lng:-6.155965 },
    { name:"Kilbarrack", lat:53.387528, lng:-6.161116 },
    { name:"Raheny", lat:53.381543, lng:-6.176371 },
    { name:"Harmonstown", lat:53.37848, lng:-6.192055 },
    { name:"Killester", lat:53.372688, lng:-6.205201 },
    { name:"Clontarf Road", lat:53.363073, lng:-6.227061 },
    { name:"Connolly", lat:53.351381, lng:-6.249535 },
    { name:"Tara Street", lat:53.34722, lng:-6.25435 },
    { name:"Pearse", lat:53.343597, lng:-6.249486 },
    { name:"Grand Canal Dock", lat:53.339416, lng:-6.236845 },
    { name:"Lansdowne Road", lat:53.334143, lng:6.229437 },
    { name:"Sandymount", lat:53.327893, lng:-6.221037 },
    { name:"Sydney Parade", lat:53.320915, lng:-6.211755 },
    { name:"Booterstown", lat:53.309855, lng:-6.195096 },
    { name:"Blackrock", lat:53.302784, lng:-6.178612 },
    { name:"Seapoint", lat:53.299175, lng:-6.165359 },
    { name:"Salthill", lat:53.295373, lng:-6.152211 },
    { name:"Dun Laoghaire", lat:53.294862, lng:-6.134578 },
    { name:"Sandycove", lat:53.288165, lng:-6.127087 },
    { name:"Glenageary", lat:53.281241, lng:-6.123138 },
    { name:"Dalkey", lat:53.275719, lng:-6.103504 },
    { name:"Killiney", lat:53.255719, lng:-6.112997 },
    { name:"Shankill", lat:53.236345, lng:-6.117026 },
    { name:"Bray", lat:53.204547, lng:-6.10067 },
    { name:"Greystones", lat:53.143935, lng:-6.060643 },
  ]
  erb :index
end

get '/results.json' do
  content_type :json
  results = {:results => [] }
  keys = %w(route service scheduled eta due info)

  if EventMachine.reactor_running?
    http = EM::HttpRequest.new("http://www.irishrail.ie/your_journey/ajax/ajaxRefreshResults.asp?station=#{URI.escape(params[:station])}").get
    response = http.response
  else
    uri = URI.parse("http://www.irishrail.ie/your_journey/ajax/ajaxRefreshResults.asp?station=#{URI.escape(params[:station])}")
    response = Net::HTTP.get_response(uri).body
  end

  Nokogiri::HTML(response).css('tr').each_with_index do |row, index|
    case index
    when 4
      @time = row.to_s.match(/(\d+:\d+)/)[1]
    else
      if @time
        if row.content.match(/Journey\s+(.+bound)/) && @current_direction != $1
          results[:results] << @directional_trains if @directional_trains
          @current_direction = $1
          @directional_trains = {:direction => @current_direction, :trains => []}
        else
          this_rows_data = {}
          row.css('td').each_with_index do |td, td_index|
            this_rows_data[keys[td_index]] = td.content
          end
          @directional_trains[:trains] << this_rows_data
        end
      end
    end
  end
  results[:results] << @directional_trains if @directional_trains
  results.to_json
end
