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
    rates = Rate.includes(:currency).where('date >= ?', 4.weeks.ago).order(:currency_id, :date)

    currencies_data = {}

    rates.each do |rate|
      currencies_data[rate.currency_id] ||= { currency: rate.currency, data: [] }
      currencies_data[rate.currency_id][:data] << { date: rate.date, value: rate.value }
    end

    table_rows = []

    currencies_data.each do |currency_id, data|
      row = [data[:currency].code]

      data[:data].each_cons(2) do |prev_week, current_week|
        difference_percentage = ((current_week[:value] - prev_week[:value]) / prev_week[:value] * 100).round(2)
        row << "#{current_week[:value].round(2)}₽ (#{difference_percentage}%)"
      end

      table_rows << row
    end

    table_rows
  end
end
