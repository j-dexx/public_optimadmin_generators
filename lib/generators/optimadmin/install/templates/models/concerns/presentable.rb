# see config/initializers/extensions.rb - is included in all Active::Record models
module Presentable
  extend ActiveSupport::Concern

  class_methods do
    def presenter
      "#{name}Presenter".constantize
    rescue NameError
      nil
    end
  end
end
