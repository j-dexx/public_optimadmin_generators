class <%= class_name %>Mailer < ApplicationMailer
  def new_<%= singular_table_name %>(<%= singular_table_name %>)
    @<%= singular_table_name %> = <%= singular_table_name %>
    mail to: site_email, subject: "<%= class_name.humanize %> Form Completed #{site_name}"
  end
end
