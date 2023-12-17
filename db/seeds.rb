require 'net/http'
require 'nokogiri'

# API cbr
# https://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=16/11/2023&date_req2=16/12/2023&VAL_NM_RQ=R01235

today = Date.today.strftime("%d/%m/%Y")
month_ago = (Date.today.months_ago(1)).strftime("%d/%m/%Y")

#### currencies ####
# name ----------------  cbr_code
# Доллар США ------------ R01235
# Евро ------------------ R01239
# Китайский юань -------- R01375

puts "Creating three currencies (USD, EUR, CNY)"

currencies = [
  ['Доллар США', 'R01235', 'USD'],
  ['Евро', 'R01239', 'EUR'],
  ['Китайский юань', 'R01375', 'CYN']
]

currencies.each do |currency|
  name, cbr_code, code = currency
  Currency.find_or_create_by!(cbr_code:, code:, name:)
end

puts "Created three currencies (USD, EUR, CNY)"

puts "Fetching currency exchange rates for the past month"

currencies = Currency.where(cbr_code: ['R01235', 'R01239', 'R01375'])

currencies.each do |currency|
  response = Net::HTTP.get(URI.parse("https://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=#{month_ago}&date_req2=#{today}&VAL_NM_RQ=#{currency.cbr_code}"))

  xml_doc = Nokogiri::XML(response)
  xml_doc.xpath('//Record').each do |record|
    date_text = record['Date']
    date = Date.parse(date_text)
    value = record.children[1].text.gsub(',', '.').to_f

    puts "Processing data for #{currency.name} - Date: #{date}, Value: #{value}"

    journal = Rate.find_or_initialize_by(currency: currency, date: date)
    journal.update(value: value)
  end
end

puts "Currency exchange rates for the past month have been fetched and stored in the database"
