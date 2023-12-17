require 'net/http'
require 'nokogiri'
require 'date'

namespace :exchange_rates do
  task :parse => :environment do
    currencies = Currency.all
    today = Date.today
    formatted_date = today.strftime('%d/%m/%Y')
    response = Net::HTTP.get(URI.parse("https://www.cbr.ru/scripts/XML_daily.asp?date_req=#{formatted_date}"))
    xml_doc = Nokogiri::XML(response)

    date = Date.parse(xml_doc.at('//ValCurs').attr('Date'))

    currencies.each do |currency|
      cbr_code = currency.cbr_code
      value = xml_doc.at("//Valute[@ID='#{cbr_code}']//Value").text.gsub(',', '.').to_f
      puts "Processing data for #{currency.name} - Date: #{date}, Value: #{value}"
      rate = Rate.find_or_initialize_by(currency: , date:)
      rate.update(value: )
    end

    puts "The requested server sent data for previous days (today: #{today})" if date != today
  end
end
