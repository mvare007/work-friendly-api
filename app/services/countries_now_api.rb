require 'net/http'

class CountriesNowApi
  BASE_URL = 'https://countriesnow.space/api'.freeze

  def initialize(version: 'v0.1')
    @version = version
  end

  def fetch_all_countries_and_cities
    api_fetch("#{BASE_URL}/#{@version}/countries")
  end

  def fetch_country_currencies
    api_fetch("#{BASE_URL}/#{@version}/countries/currency")
  end

  def fetch_country_dial_codes
    api_fetch("#{BASE_URL}/#{@version}/countries/codes")
  end

  private

  def api_fetch(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response, symbolize_names: true)
    error = data[:error]
    message = data[:msg]
    Rails.logger.info("Fetched data from #{url}\nError: #{error}\nMessage: #{message}")

    data[:data]
  rescue StandardError => e
    Rails.logger.error("Error fetching data from #{url}\n#{e.message}")
  end
end
