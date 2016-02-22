class <%= class_name %>Presenter < BasePresenter
  presents :<%= singular_table_name %>
  delegate :id, to: :<%= singular_table_name %>
end
