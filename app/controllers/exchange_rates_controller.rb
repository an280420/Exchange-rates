class ExchangeRatesController < ApplicationController
  def chart
    @chart_data = chart_data
  end

  def table
  end

  private

  def chart_data
    rates = Rate.includes(:currency).where('date >= ?', 1.month.ago).order(:currency_id)
    rates_group_by_date = rates.group_by(&:date)
    
    # Добавим даты в массив
    dates = ['x'] + rates_group_by_date.keys.map(&:to_s)
  
    columns = []
    columns << dates
  
    # Добавим данные по каждой валюте
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
  
end
