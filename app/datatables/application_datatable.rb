class ApplicationDataTable
  def initialize(collection)
    @collection = collection
  end

  def prepare_data
    {
      data: serialized_data,
      columns:
    }
  end

  private

  ##
  # This function serializes each item in a collection
  # Returns an array of serialized data.
  def serialized_data
    @collection.map { |item| serialize_item(item) }
  end

  ##
  # Customize this method in subclass to serialize each item in the collection
  # Returns a hash - Example { id: 1, name: 'John Doe' }
  def serialize_item(_item)
    {}
  end

  ##
  # Override this method in subclasses to customize the columns
  # Returns an array of hashes - Example [{ field: 'name', header: 'Name' }]
  def columns
    []
  end
end
