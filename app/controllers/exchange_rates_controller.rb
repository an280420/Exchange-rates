class ExchangeRatesController < ApplicationController
  def chart
    @chart_data = chart_data
  end

  def table
    @table_data = table_data
  end

  private

  def chart_data
    rates = Rate.includes(:currency).where('date >= ?', 1.month.ago).order(:currency_id)
    rates_group_by_date = rates.group_by(&:date)
    
    dates = ['x'] + rates_group_by_date.keys.map(&:to_s)
  
    columns = []
    columns << dates
  
    Currency.all.each do |currency|
      column_data = [currency.code]
  
      rates_for_currency = rates_group_by_date.map { |date, rates| rates.find { |rate| rate.currency_id == currency.id } }
      column_data += rates_for_currency.map { |rate| rate ? rate.value : nil }
  
      columns << column_data
    end
  
    { 
      x: 'x',
      columns: columns
    }
  end

  def table_data
    rates_data = Rate.group_by_week_with_first_value

    # hash with the value of the rates at the beginning of the weeks and the percentage change for each currency
    currencies_data = {}
    rates_data.each do |week_start, currencies|
      currencies.each do |currency_id, value|
        currencies_data[currency_id] ||= { values: [], percentages: [] }
        currencies_data[currency_id][:values] << { week_start: week_start, value: value }

        if currencies_data[currency_id][:values].length > 1
          prev_value = currencies_data[currency_id][:values][-2][:value]
          current_value = currencies_data[currency_id][:values][-1][:value]
          percentage_change = ((current_value - prev_value) / prev_value * 100).round(2)
          currencies_data[currency_id][:percentages] << { week_start: week_start, percentage: percentage_change }
        end
      end
    end

    table_rows = []
    currencies_data.each do |currency_id, data|
      row = [Currency.find(currency_id).code]

      data[:values].each_with_index do |week_data, index|
        percent = data[:percentages][index][:percentage].round(2) if index < data[:percentages].length
        percent_as_text = " (#{'+' if percent.positive?}#{percent}%)" if percent 
        row << "#{week_data[:value].round(2)}₽#{percent_as_text if percent_as_text}"
      end

      table_rows << row
    end

    table_rows
  end
end
