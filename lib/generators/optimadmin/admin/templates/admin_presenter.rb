module Optimadmin
  class <%= class_name %>Presenter
    include Optimadmin::PresenterMethods
    presents :<%= singular_table_name %>
    delegate :id, :title, to: :<%= singular_table_name %>

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def optimadmin_summary
      # h.simple_format <%= singular_table_name %>.summary
    end
  end
end
