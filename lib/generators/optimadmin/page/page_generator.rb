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

    def create_tests
      directory 'spec'
    end

    # Begin app methods

    def add_app_route
      inject_into_file 'config/routes.rb', "\n\n  resources :pages, only: :show\n", after: 'Rails.application.routes.draw do'
    end

    def add_to_navigation_constants
      inject_into_file 'config/initializers/navigation_constants.rb', "'Dynamic Page' => 'Page',\n", after: "'Module Page' => 'Optimadmin::ModulePage',"
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
  end
end
