module Optimadmin
  class <%= class_name.pluralize %>Controller < Optimadmin::ApplicationController
    before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

    def index
      @pagination_helper = <%= class_name %>.field_order(params[:order])
                                            .field_search(params[:search])
                                            .pagination(params[:page], params[:per_page])

      @<%= plural_table_name %> = Optimadmin::BaseCollectionPresenter.new(
        collection: @pagination_helper,
        view_template: view_context,
        presenter: Optimadmin::<%= class_name %>Presenter)
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
        redirect_to_index_or_continue_editing(@<%= singular_table_name %>)
      else
        render :new
      end
    end

    def update
      if @<%= singular_table_name %>.update(<%= "#{singular_table_name}_params" %>)
        redirect_to_index_or_continue_editing(@<%= singular_table_name %>)
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
      @<%= singular_table_name %> = <%= class_name %>.find(params[:id])
    end

    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>)
            .permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %><%= ', ' if attributes.select{|x| x.type == :image || x.type == :document }.size >= 1 %><%= attributes.select{|x| x.type == :image ||  x.type == :document }.map { |x| ":remove_#{x.name}, :remote_#{x.name}_url, :#{x.name}_cache" }.join(', ') %>)
      <%- end -%>
    end
  end
end
