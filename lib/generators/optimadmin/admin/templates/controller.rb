module Optimadmin
  class <%= class_name.pluralize %>Controller < Optimadmin::ApplicationController
    before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

    def index
      @<%= plural_table_name %> = <%= class_name %>.all
    end

    def show
    end

    def new
      @<%= singular_table_name %> = <%= class_name %>.new
    end

    def edit
    end

    def create
      @<%= singular_table_name %> = <%= class_name %>.new(<%= "#{singular_table_name}_params" %>)
      if @<%= singular_table_name %>.save
        redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully created.'" %>
      else
        render :new
      end
    end

    def update
      if @<%= singular_table_name %>.update(<%= "#{singular_table_name}_params" %>)
        redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully updated.'" %>
      else
        render :edit
      end
    end

    def destroy
      @<%= singular_table_name %>.destroy
      redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} was successfully destroyed.'" %>
    end

  private


    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = @<%= singular_table_name %>.find(params[:id])
    end

    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
  end
end