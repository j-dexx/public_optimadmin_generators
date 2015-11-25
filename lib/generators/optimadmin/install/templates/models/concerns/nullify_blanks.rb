# http://stackoverflow.com/questions/7202319/rails-force-empty-string-to-null-in-the-database
module NullifyBlanks
  extend ActiveSupport::Concern

  included do
    before_save :normalize_blank_values
  end

  def normalize_blank_values
    attributes.each do |column, _value|
      self[column].present? || self[column] = nil
    end
  end
end
