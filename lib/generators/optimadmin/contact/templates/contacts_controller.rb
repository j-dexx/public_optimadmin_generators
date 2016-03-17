class <%= class_name.pluralize %>Controller < ApplicationController
  def new
    @<%= singular_table_name %> = <%= class_name %>.new
  end

  def create
    @<%= singular_table_name %> = <%= class_name %>.new(<%= singular_table_name %>_params)
    if @<%= singular_table_name %>.valid?
      <%= class_name %>Mailer.new_<%= singular_table_name %>(@<%= singular_table_name %>).deliver_now
      redirect_to new_<%= singular_table_name %>_path, notice: 'Thank you for your submission.'
    else
      render :new
    end
  end

  private

  def <%= singular_table_name %>_params
    params.require(:<%= singular_table_name %>)
          .permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
  end
end
