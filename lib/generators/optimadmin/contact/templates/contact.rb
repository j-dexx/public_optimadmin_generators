class <%= class_name %>
  include ActiveModel::Model
  attr_accessor <%= attributes_names.map { |name| ":#{name}" }.join(', ') %>

  validates <%= attributes_names.map { |name| ":#{name}" }.join(', ') %>, presence: true

  # validate :email_or_telephone

  # def email_or_telephone
  #   errors.add(:email, 'or telephone must be provided') if email.blank? && telephone.blank?
  # end
end
