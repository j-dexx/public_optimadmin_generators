class PagePresenter < BasePresenter
  presents :page
  delegate :title, to: :page

  def content
    h.raw page.content
  end
end
