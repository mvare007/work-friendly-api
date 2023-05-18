# https://jsonapi-rb.org/guides/serialization/defining.html
# SerializableUser.new(object: User.first).as_jsonapi
class SerializableUser < ApplicationSerializer
  type :users

	attributes :first_name, :last_name, :email, :address, :zip_code, :phone_number, :payment_info
end