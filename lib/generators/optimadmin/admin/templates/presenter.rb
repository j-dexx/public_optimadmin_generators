module Optimadmin
  class <%= class_name %>Presenter < Optimadmin::BasePresenter
    presents :<%= singular_table_name %>

    def id
      <%= singular_table_name %>.id
    end

    def title
      #<%= singular_table_name %>.title
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def optimadmin_summary
      #h.raw <%= singular_table_name %>.summary
    end
  end
end
