class PagePresenter < BasePresenter
  presents :page

  def title
    page.title
  end

  def content
    h.raw page.content
  end

  def image
    h.image_tag page.image.show, alt: page.title if page.image?
  end

end
