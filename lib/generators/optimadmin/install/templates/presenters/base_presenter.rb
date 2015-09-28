class BasePresenter

  attr_reader :object
  delegate :to_param, :to_partial_path, to: :object

  def initialize(object:, view_template:)
    @object = object
    @view_template = view_template
    create_image_methods if @object
  end

  def id
    object.id
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def self.add_image_method(column_name)
    define_method(column_name) do |version, options = {}|
      h.image_tag object.public_send("#{ column_name }_url", version), options if object.public_send("#{ column_name }?")
    end
  end

  def self.add_image_version_method(column_name, version_name)
    define_method("#{ version_name }_#{ column_name }") do |options = {}|
      send(column_name, version_name, options)
    end
  end

  private

  def create_image_methods
    @object.class.uploaders.each do |column_name, uploader|
      BasePresenter.add_image_method(column_name)
      uploader.versions.keys.each do |version_name|
        BasePresenter.add_image_version_method(column_name, version_name)
      end
    end
  end

  def h
    @view_template
  end
end
