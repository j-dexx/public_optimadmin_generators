require 'rails/generators/base'

module Optimadmin
  class ErrorMessagesGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_controller
      copy_file 'errors_controller.rb', 'app/controllers/errors_controller.rb'
    end

    def copy_views
      copy_file '403.html.erb', 'app/views/errors/403.html.erb'
      copy_file '404.html.erb', 'app/views/errors/404.html.erb'
      copy_file '422.html.erb', 'app/views/errors/422.html.erb'
      copy_file '500.html.erb', 'app/views/errors/500.html.erb'
    end

    def append_to_controller
      inject_into_file 'app/controllers/application_controller.rb', application_controller, after: 'class ApplicationController < ActionController::Base'
    end

    def append_to_application
      inject_into_file 'config/application.rb', application_file, after: 'class Application < Rails::Application'
    end

    def create_route
      insert_into_file 'config/routes.rb', route, after: 'Rails.application.routes.draw do'
    end

    private

    def route
      <<-ROUTE.strip_heredoc.indent(2)
          \n
          %w( 403 404 422 500 ).each do |code|
            get code, to: 'errors#show', code: code
          end

          # This has to be the last route in your list
          match "*path", to: "errors#show", via: :all, code: 404 unless Rails.application.config.consider_all_requests_local
        ROUTE
    end

    def application_controller
      <<-'CONTROLLER'.strip_heredoc.indent(2)
          \n
          unless Rails.application.config.consider_all_requests_local
            rescue_from Exception, with: -> { render_error(500) }
            rescue_from ActiveRecord::RecordNotFound, with: -> { render_error(404) }
            rescue_from ActionController::RoutingError, with: -> { render_error(404) }
          end

          def render_error(status)
            respond_to do |format|
              format.html { render "errors/#{status}", status: status }
              format.all { render nothing: true, status: status }
            end
          end
        CONTROLLER
    end

    def application_file
      <<-FILE.strip_heredoc.indent(4)
        \nconfig.exceptions_app = self.routes
      FILE
    end
  end
end
