module Optimadmin
  class SeoEntryPresenter < Optimadmin::BasePresenter
    presents :seo_entry

    def id
      seo_entry.id
    end

    def title
      seo_entry.title
    end

    def nominal_url
      h.link_to seo_entry.nominal_url, seo_entry.nominal_url, target: '_blank'
    end
  end
end
