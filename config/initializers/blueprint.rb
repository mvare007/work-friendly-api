require 'oj'

Blueprinter.configure do |config|
  config.generator = Oj # default is JSON
	config.sort_fields_by = :definition
  config.datetime_format = ->(datetime) { datetime.nil? ? datetime : datetime.strftime('%d-%m-%Y %H:%M:%S') }
end
