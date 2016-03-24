require 'rails/generators/base'

module Optimadmin
  class AdminGenerator < Rails::Generators::NamedBase
    argument :attributes, type: :array, default: [], banner: 'field:type'
    source_root File.expand_path('../templates', __FILE__)

    def generate_controller
      if attributes.map(&:name).include?('publish_at') &&
         attributes.map(&:name).include?('expire_at')
        template 'display_status/controller.rb', "app/controllers/optimadmin/#{plural_file_name}_controller.rb"
        template 'display_status/expired_controller.rb', "app/controllers/optimadmin/#{plural_file_name}/expired_controller.rb"
        template 'display_status/published_controller.rb', "app/controllers/optimadmin/#{plural_file_name}/published_controller.rb"
        template 'display_status/scheduled_controller.rb', "app/controllers/optimadmin/#{plural_file_name}/scheduled_controller.rb"
      else
        template 'display_toggle/controller.rb', "app/controllers/optimadmin/#{plural_file_name}_controller.rb"
      end
    end

    def generate_views
      template '_form.html.erb', "app/views/optimadmin/#{plural_file_name}/_form.html.erb"
      template 'new.html.erb', "app/views/optimadmin/#{plural_file_name}/new.html.erb"
      template 'edit.html.erb', "app/views/optimadmin/#{plural_file_name}/edit.html.erb"
      if attributes.map(&:name).include?('display')
        template 'display_toggle/index.html.erb', "app/views/optimadmin/#{plural_file_name}/index.html.erb"
        template 'display_toggle/_partial.html.erb', "app/views/optimadmin/#{plural_file_name}/_#{singular_table_name}.html.erb"
      elsif attributes.map(&:name).include?('publish_at') &&
            attributes.map(&:name).include?('expire_at')
        template 'display_status/index.html.erb', "app/views/optimadmin/#{plural_file_name}/index.html.erb"
        template 'display_status/_partial.html.erb', "app/views/optimadmin/#{plural_file_name}/_#{singular_table_name}.html.erb"
      end
    end

    def generate_admin_presenter
      template 'admin_presenter.rb', "app/presenters/optimadmin/#{singular_table_name}_presenter.rb"
    end

    def generate_presenter
      template 'presenter.rb', "app/presenters/#{singular_table_name}_presenter.rb"
    end

    def generate_controller_spec
      template 'controller_spec.rb', "spec/controllers/optimadmin/#{singular_table_name}_controller_spec.rb"
    end

    def generate_presenter_spec
      template 'presenter_spec.rb', "spec/presenters/#{singular_table_name}_presenter_spec.rb"
    end

    def add_to_module_links
      insert_into_file 'app/views/optimadmin/shared/sidebar/_module_links.html.erb', after: "<ul id=\"modules\" class=\"content-category-list\">\n" do
        "<%= module_link(content: \"#{singular_table_name.titleize.pluralize}\", model: #{class_name}, path: #{index_helper}_path) %>\n"
      end
    end

    def create_route
      insert_into_file 'config/routes.rb', after: "Optimadmin::Engine.routes.draw do\n" do
        unless attributes.count { |x| x.type == :image }.zero?
          image_route
        else
          non_image_route
        end
      end

      if attributes.map(&:name).include?('publish_at') &&
         attributes.map(&:name).include?('expire_at')
        insert_into_file 'config/routes.rb', display_status_routes, after: "resources :#{plural_table_name}, except: [:show] do\n  collection do\n"
      end
    end

    private

    def display_status_routes
      <<-ROUTE.strip_heredoc
        resources :expired, as: 'expired_#{plural_table_name}', controller: '#{plural_table_name}/expired'
        resources :scheduled, as: 'scheduled_#{plural_table_name}', controller: '#{plural_table_name}/scheduled'
        resources :published, as: 'published_#{plural_table_name}', controller: '#{plural_table_name}/published'
      ROUTE
    end

    def image_route
      <<-ROUTE.strip_heredoc
        resources :#{plural_table_name}, except: [:show] do
          collection do
            post 'order'
          end
          member do
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
      <<-ROUTE.strip_heredoc
        resources :#{plural_table_name}, except: [:show] do
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
