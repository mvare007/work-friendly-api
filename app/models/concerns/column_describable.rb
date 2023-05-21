module ColumnDescribable
  extend ActiveSupport::Concern

  class_methods do
    def described_columns(...)
      columns_hash.transform_keys(&:to_sym)
                  .slice(...)
                  .transform_values(&:type)
    end
  end
end
