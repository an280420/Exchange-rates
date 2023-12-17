require 'rails_helper'

RSpec.describe "exchange_rates/table.html.erb", type: :view do
  before do
    assign(:table_data, [
      ['USD', '100₽ (+3%)', '103₽ (-6%)', '96₽ (+5%)', '100₽ (-3%)'],
      ['EUR', '100₽ (+3%)', '103₽ (-6%)', '96₽ (+5%)', '100₽ (-3%)'],
      ['CNY', '100₽ (+3%)', '103₽ (-6%)', '96₽ (+5%)', '100₽ (-3%)']
    ])
  end

  it "renders the table header" do
    render

    expect(rendered).to have_selector("header h1", text: "ExchangeRates")
    expect(rendered).to have_selector("main table thead th", text: "Валюта")
    expect(rendered).to have_selector("main table thead th", text: "4 недели назад")
    expect(rendered).to have_selector("main table thead th", text: "3 недели назад")
    expect(rendered).to have_selector("main table thead th", text: "позапрошлая неделя")
    expect(rendered).to have_selector("main table thead th", text: "прошлая неделя")
  end

  it "renders the table rows with data" do
    render

    expect(rendered).to have_selector("main table tbody tr td", text: "USD")
    expect(rendered).to have_selector("main table tbody tr td", text: "100₽ (+3%)")
  end
end
