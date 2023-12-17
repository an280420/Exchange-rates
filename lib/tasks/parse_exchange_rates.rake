require 'net/http'
require 'nokogiri'
require 'date'

namespace :exchange_rates do
  task :parse => :environment do
    currencies = Currency.all
    date = Date.today
    formatted_date = date.strftime('%d/%m/%Y')
    response = Net::HTTP.get(URI.parse("https://www.cbr.ru/scripts/XML_daily.asp?date_req=#{formatted_date}"))
    xml_doc = Nokogiri::XML(response)

    currencies.each do |currency|
      cbr_code = currency.cbr_code
      value = xml_doc.at("//Valute[@ID='#{cbr_code}']//Value").text.gsub(',', '.').to_f
      puts "Processing data for #{currency.name} - Date: #{formatted_date}, Value: #{value}"
      rate = Rate.find_or_initialize_by(currency: , date:)
      rate.update(value: )
    end
  end
end
