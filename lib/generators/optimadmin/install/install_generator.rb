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
  end
end
