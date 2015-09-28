module Optimadmin
  class PagePresenter < Optimadmin::BasePresenter
    presents :page
    delegate :id, :title, to: :page

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def content
      h.raw page.content
    end
  end
end
