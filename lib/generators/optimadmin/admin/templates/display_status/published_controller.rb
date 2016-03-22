module Optimadmin
  module <%= class_name.pluralize %>
    class PublishedController < Optimadmin::<%= class_name.pluralize %>Controller
      def index
        @pagination_helper = @published_items
                             .pagination(params[:page], params[:per_page])

        @<%= plural_table_name %> = Optimadmin::BaseCollectionPresenter.new(
          collection: @pagination_helper,
          view_template: view_context,
          presenter: Optimadmin::<%= class_name %>Presenter
        )
      end
    end
  end
end
