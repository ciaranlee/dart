require 'rubygems'

require "bundler"
Bundler.setup

require 'rack'
require 'sinatra'
require "sinatra/reloader" if development?
require 'nokogiri'
require 'json'

set :public, File.dirname(__FILE__) + '/public'

get '/results.json' do
  keys = %w(route service scheduled eta due info)
  row_data = []
  uri = URI.parse("http://www.irishrail.ie/your_journey/ajax/ajaxRefreshResults.asp?station=#{params[:station]}")
  response = Net::HTTP.get_response(uri)
  doc = Nokogiri::HTML(response.body)
  doc.css('tr').each_with_index do |row, index|
    case index
    when 4
      @time = row.to_s.match(/(\d+:\d+)/)[1]
      puts "time is #{@time}"
    else
      if @time
        if row.content.match(/Journey\s+(.+bound)/)
          @current_direction = $1
        else
          this_rows_data = {:direction => @current_direction}
          row.css('td').each_with_index do |td, td_index|
            this_rows_data[keys[td_index]] = td.content
          end
          row_data << this_rows_data
        end
      end
    end
  end
  {:results => row_data }.to_json
end
