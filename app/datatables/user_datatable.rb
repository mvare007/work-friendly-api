class UserDatatable < ApplicationDatatable
  def resource_class = User

  def sort_field = :first_name

  def permitted_actions = %i[show update destroy]

  def sortable_columns
    %i[first_name last_name created_at updated_at]
  end

  def filterable_columns
    %i[id first_name last_name email]
  end
end
