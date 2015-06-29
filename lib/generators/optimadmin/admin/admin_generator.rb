require 'rails/generators/base'

module Optimadmin
  class AdminGenerator < Rails::Generators::NamedBase

    argument :attributes, type: :array, default: [], banner: "field:type"
    source_root File.expand_path('../templates', __FILE__)

    def generate_controller
      template "controller.rb", "app/controllers/optimadmin/#{plural_file_name}_controller.rb"
    end

    def generate_views
      template "_form.html.erb", "app/views/optimadmin/#{plural_file_name}/_form.html.erb"
      template "index.html.erb", "app/views/optimadmin/#{plural_file_name}/index.html.erb"
      template "new.html.erb", "app/views/optimadmin/#{plural_file_name}/new.html.erb"
      template "edit.html.erb", "app/views/optimadmin/#{plural_file_name}/edit.html.erb"
    end

    def add_to_module_links
      insert_into_file "app/views/optimadmin/shared/sidebar", after: "<ul class=\"content-category-list\">" do
        "<%= module_link(model: #{ singular_table_name.titleize }, path: #{ index_helper }_path) %>"
      end
    end

    def create_route
      insert_into_file "config/routes.rb", after: "Optimadmin::Engine.routes.draw do\n" do
        if yes? "Has image?"
          image_route
        else
          non_image_route
        end
      end
    end

  private

    def image_route
      <<-ROUTE.strip_heredoc.indent(2)
        resources :#{ plural_table_name }, except: [:show] do
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

    def non_image_route
      <<-ROUTE.strip_heredoc.indent(2)
        resources :#{ plural_table_name }, except: [:show] do
          collection do
            post 'order'
          end
          member do
            get 'toggle'
          end
        end
      ROUTE
    end
  end
end
