require 'net/http'

class CountriesNowApi
  def initialize(version: 'v0.1')
    @version = version
  end

  def fetch_all_countries_and_cities
    api_fetch("#{base_url}/countries")
  end

  def fetch_country_currencies
    api_fetch("#{base_url}/countries/currency")
  end

  def fetch_country_dial_codes
    api_fetch("#{base_url}/countries/codes")
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

  def base_url
    "https://countriesnow.space/api/#{@version}"
  end
end
