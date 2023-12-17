require 'rails_helper'

RSpec.describe "exchange_rates/chart.html.erb", type: :view do
  before(:each) do
    assign(:chart_data, { x: 'x', columns: [['x', '2023-12-16', '2023-12-17'], ['USD', 100, 100]] })
    render
  end

  it "renders the chart header" do
    expect(rendered).to have_selector("header h1", text: "ExchangeRates")
    expect(rendered).to have_selector("header p", text: "chart")
  end

  it "renders the main content with chart data" do
    expect(rendered).to have_selector("main #chart")
    expect(rendered).to have_content("var chartData =")
    expect(rendered).to include("{\"x\":\"x\",\"columns\":[[\"x\",\"2023-12-16\",\"2023-12-17\"],[\"USD\",100,100]]}")
  end

  it "renders the link to rates table" do
    expect(rendered).to have_selector("main a.button[href='#{exchange_rates_table_path}']", text: "Rates table")
  end
end
