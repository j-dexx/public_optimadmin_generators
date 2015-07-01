module Optimadmin
  class <%= class_name %>Presenter < Optimadmin::BasePresenter
    presents :<%= singular_table_name %>
  end
end