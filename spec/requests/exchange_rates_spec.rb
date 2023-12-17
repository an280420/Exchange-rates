require 'rails_helper'

RSpec.describe "ExchangeRates", type: :request do
  describe "GET /chart" do
    it "returns http success" do
      get "/exchange_rates/chart"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /table" do
    it "returns http success" do
      get "/exchange_rates/table"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end
end
