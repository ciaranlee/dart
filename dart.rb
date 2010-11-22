require 'rubygems'

require "bundler"
Bundler.setup

require 'rack'
require 'sinatra'
require "sinatra/reloader" if development?
require 'nokogiri'
require 'json'

configure :production do
  require 'newrelic_rpm'
end


set :public, File.dirname(__FILE__) + '/public'

get '/' do
  redirect '/index.html'
end

get '/results.json' do
  content_type :json
  results = {:results => [] }
  keys = %w(route service scheduled eta due info)

  uri = URI.parse("http://www.irishrail.ie/your_journey/ajax/ajaxRefreshResults.asp?station=#{URI.escape(params[:station])}")
  response = Net::HTTP.get_response(uri)

  Nokogiri::HTML(response.body).css('tr').each_with_index do |row, index|
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
