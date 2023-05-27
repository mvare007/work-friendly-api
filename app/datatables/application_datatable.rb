class ApplicationDatatable
  def initialize(collection, serializer_view = nil)
    @collection = collection
    @serializer_view = serializer_view
  end

  def to_hash
    {
      data:,
      sort_field:,
      sortable_columns:,
      filterable_columns:,
      permitted_actions:
    }
  end

  def to_json(*_args)
    to_hash.to_json
  end

  private

  ##
  # Determines allowed CRUD actions for the datatable.
  def permitted_actions
    %i[show update destroy]
  end

  ##
  # Returns an array of sortable columns for the resource class.
  def sortable_columns
    resource_class.column_names
  end

  ##
  # Returns an array of searchable columns for the resource class.
  def filterable_columns
    resource_class.column_names
  end

  ##
  # Returns a serialized hash of a collection using a specified serializer view.
  def data
    serializer.render_as_hash(@collection, view: @serializer_view)
  end

  ##
  # The column used for default ordering
  def sort_column
    sortable_columns.empty? ? nil : sortable_columns.first
  end

  ##
  # Maps the datatable class to it's model class.
  def resource_class
    self.class.name.gsub('Datatable', '').constantize
  end

  # Returns the serializer class for a given resource class.
  def serializer
    "#{resource_class.name}Blueprint".constantize
  end
end
