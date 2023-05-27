class BusinessDatatable < ApplicationDataTable
  def sort_field = :name

  def permitted_actions = %i[show update destroy]

  def sortable_columns
    %i[
      name
      email
      address
      longitude
      latitude
      phone_number
      vat_number
      capacity
      zip_code
      city_name
      business_type_name
    ]
  end

  def filterable_columns
    %i[
      name
      email
      address
      longitude
      latitude
      phone_number
      vat_number
      capacity
      zip_code
      city_name
      business_type_name
    ]
  end
end
