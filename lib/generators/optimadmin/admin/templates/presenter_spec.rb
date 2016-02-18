require 'rails_helper'

RSpec.describe <%= class_name %>Presenter, type: :presenter, <%= singular_table_name %>: true do
  let(:<%= singular_table_name %>) { build(:<%= singular_table_name %>) }
  subject(:<%= singular_table_name %>_presenter) { <%= class_name %>Presenter.new(object: <%= singular_table_name %>, view_template: view) }
end
