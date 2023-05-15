class Countries::SyncService
  include Callable

  ACTIVE_COUNTRIES = [
    'Portugal'
  ].freeze

  def initialize(api_client: CountriesNowApi.new)
    @api_client = api_client
  end

  def call
    sync_countries_and_cities
    sync_currencies_and_iso_codes
    sync_dial_codes
  end

  private

  def sync_countries_and_cities
    countries = @api_client.fetch_all_countries_and_cities

    countries.each do |country_data|
      country_name = country_data[:country]
      country = Country.find_or_initialize_by(name: country_name)
      country.active = ACTIVE_COUNTRIES.include?(country_name)
      country.save!
      next unless country.active?

      country_data[:cities].each do |city_name|
        country.cities.find_or_create_by(name: city_name)
      end
    end
  end

  def sync_currencies_and_iso_codes
    currencies_and_iso_codes = @api_client.fetch_country_currencies

    currencies_and_iso_codes.each do |data|
      country = Country.find_by(name: data[:name])
      country&.update(
        currency: data[:currency],
        iso2_code: data[:iso2],
        iso3_code: data[:iso3]
      )
    end
  end

  def sync_dial_codes
    dial_codes = @api_client.fetch_country_dial_codes

    dial_codes.each do |dial_code_data|
      country = Country.find_by(name: dial_code_data[:name])
      country&.update(dialing_code: dial_code_data[:dial_code])
    end
  end
end
