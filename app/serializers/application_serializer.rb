class ApplicationSerializer < JSONAPI::Serializable::Resource
	STRFTIME_FORMAT = '%d/%m/%Y %H:%M:%S'.freeze

	attribute :created_at do
		@object.created_at.strftime(STRFTIME_FORMAT)
	end

	attribute :updated_at do
		@object.created_at.strftime(STRFTIME_FORMAT)
	end
end