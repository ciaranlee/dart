require 'rubygems'

require "bundler"
Bundler.setup

require 'rack'
require 'sinatra'
require "sinatra/reloader" if development?
require 'nokogiri'

get '/' do
  @tds = %w(journey service scheduled eta due info)
  @row_data = []
  uri = URI.parse("http://www.irishrail.ie/your_journey/ajax/ajaxRefreshResults.asp?station=Seapoint")
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
          this_rows_data = [@current_direction]
          row.css('td').each_with_index do |td, td_index|
            this_rows_data << td.content
          end
          @row_data << this_rows_data
          puts "#{this_rows_data}"
        end
      end
    end
  end
  'hello'
end