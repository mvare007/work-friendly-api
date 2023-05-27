require 'oj'
require_relative '../../app/blueprints/transformers/lower_camel_transformer'

Blueprinter.configure do |config|
  config.generator = Oj # default is JSON
	config.sort_fields_by = :definition
  config.datetime_format = ->(datetime) { datetime.nil? ? datetime : datetime.strftime('%d-%m-%Y %H:%M:%S') }
  # config.default_transformers = [LowerCamelTransformer]
end
