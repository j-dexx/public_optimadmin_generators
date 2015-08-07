require 'rails/generators/base'

module Optimadmin
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def mount_engine
      route 'mount Optimadmin::Engine => "/admin"'
    end

    def add_routes
      append_to_file "config/routes.rb", "Optimadmin::Engine.routes.draw do\nend"
    end

    def add_sidebar
      copy_file "sidebar/_module_links.html.erb", "app/views/optimadmin/shared/sidebar/_module_links.html.erb"
    end

    def add_presenters
      directory "presenters", "app/presenters"
    end

    def add_model_concerns
      directory "models/concerns", "app/models/concerns"
    end

    def copy_google_analytics_profile
      copy_file "initializers/ga_profile.rb", "config/initializers/ga_profile.rb"
    end

    def navigation_constants
      copy_file "initializers/navigation_constants.rb", "config/initializers/navigation_constants.rb"
    end
  end
end
