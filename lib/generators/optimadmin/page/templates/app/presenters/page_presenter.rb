class PagePresenter < BasePresenter
  presents :page
  delegate :title, to: :page

  def linked_text(text = 'View', options = {})
    h.link_to text, h.page_path(page), options
  end

  def content
    h.raw page.content
  end
end
