require 'rails/generators/base'

module Optimadmin
  class ContactGenerator < Rails::Generators::NamedBase
    argument :attributes, type: :array, default: [], banner: 'field:type'
    source_root File.expand_path('../templates', __FILE__)

    def contact_form
      template '_form.html.erb', "app/views/#{plural_file_name}/_form.html.erb"
    end

    def contact_mailer
      template 'new_contact.html.erb', "app/views/#{singular_table_name}_mailer/new_#{singular_table_name}.html.erb"
    end

    def contacts_controller
      template 'contacts_controller.rb', "app/controllers/#{plural_file_name}_controller.rb"
    end

    def contacts_new
      copy_file 'new.html.erb', "app/views/#{plural_file_name}/new.html.erb"
    end

    def contacts_mailer
      template 'contact_mailer.rb', "app/mailers/#{singular_table_name}_mailer.rb"
    end

    def contacts_model
      template 'contact.rb', "app/models/#{singular_table_name}.rb"
    end

    def add_app_route
      inject_into_file 'config/routes.rb', "\n\n  resources :#{plural_file_name}, only: [:new, :create]\n", after: 'Rails.application.routes.draw do'
    end
  end
end
