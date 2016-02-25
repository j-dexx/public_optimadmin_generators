class PagePresenter < BasePresenter
  presents :page
  delegate :title, to: :page

  def linked_text(text = 'View', options = {})
    h.link_to text, h.model_name_path(model_name), options
  end

  def content
    h.raw page.content
  end
end
