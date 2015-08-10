module Optimadmin
  class PageGenerator < Rails::Generators::Base

    source_root File.expand_path("templates", File.dirname(__FILE__))

    # Begin required methods

    def create_seo_table
      copy_file 'migration.rb', "db/migrate/#{DateTime.now.strftime("%Y%m%d%H%M%S")}_create_pages.rb"
    end

    def create_app_files
      directory 'app'
    end

    # Begin app methods

    def add_app_route
      inject_into_file 'config/routes.rb', "\n\n  resources :pages, only: :show\n", after: 'Rails.application.routes.draw do'
    end

    # Begin admin methods

    def add_admin_route
      insert_into_file "config/routes.rb", admin_routes, after: "Optimadmin::Engine.routes.draw do\n"
    end

    def add_to_admin_navigation
      insert_into_file "app/views/optimadmin/shared/sidebar/_module_links.html.erb", after: "<ul id=\"modules\" class=\"content-category-list\">\n" do
        "<%= module_link(model: Page, path: pages_path) %>\n"
      end
    end

    private

      def admin_routes
        <<-ROUTE.strip_heredoc.indent(2)
          \n
          resources :pages, except: :show do
            collection do
              post 'order'
            end
            member do
              get 'edit_images'
              get 'toggle'
              get 'edit_images'
              post 'update_image_default'
              post 'update_image_fill'
              post 'update_image_fit'
            end
          end
        ROUTE
      end
=begin
    def add_route
      inject_into_file 'config/routes.rb', "\n\n  get 'sitemap', to: 'application#sitemap'\n\n", after: 'Rails.application.routes.draw do'
      insert_into_file "config/routes.rb", admin_routes, after: "Optimadmin::Engine.routes.draw do\n"
    end

    def add_to_application_controller
      inject_into_file 'app/controllers/application_controller.rb', application_controller, after: 'class ApplicationController < ActionController::Base'
    end

    def add_to_navigation
      insert_into_file "app/views/optimadmin/shared/sidebar/_module_links.html.erb", after: "<ul id=\"modules\" class=\"content-category-list\">\n" do
        "<%= module_link(model: SeoEntry, path: seo_entries_path) %>\n"
      end
    end

    private

      def admin_routes
        <<-ROUTE.strip_heredoc.indent(2)
          \n
          resources :seo_entries, except: [:show] do
            collection do
              post 'order'
              get 'rebuild_seo'
            end
            member do
              get 'toggle'
            end
          end
        ROUTE
      end

      def application_controller
        <<-CONTROLLER.strip_heredoc.indent(2)
          \n
          before_action :set_seo_variables

          def sitemap
            @seo_entries = SeoEntry.where(in_sitemap: true).order(:nominal_url)

            respond_to do |format|
              format.html
              format.xml
            end
          end

          def set_seo_variables
            seo_entry = SeoEntry.find_by_nominal_url(request.path)
            return unless seo_entry
            @title = seo_entry.title
            @meta_description = seo_entry.meta_description
            @meta_tags = seo_entry.title
          end
        CONTROLLER
      end
=end
  end
end
