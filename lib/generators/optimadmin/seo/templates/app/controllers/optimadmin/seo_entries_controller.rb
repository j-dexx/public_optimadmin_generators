module Optimadmin
  class SeoEntriesController < Optimadmin::ApplicationController
    before_action :set_seo_entry, only: [:edit, :update]

    def index
      @seo_entries = Optimadmin::BaseCollectionPresenter.new(collection: SeoEntry.where('nominal_url LIKE :search OR title LIKE :search OR meta_description LIKE :search', search: "#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::SeoEntryPresenter)
    end

    def edit
    end

    def update
      if @seo_entry.update_attributes(seo_entry_params)
        redirect_to seo_entries_path, notice: "SEO Entry successfully updated."
      else
        render :edit
      end
    end

    def rebuild_seo
      SEO.rebuild!
      redirect_to seo_entries_path, notice: "SEO entries rebuilt."
    end

    private

      def set_seo_entry
        @seo_entry = SeoEntry.find(params[:id])
      end

      def seo_entry_params
        params.require(:seo_entry).permit(:title, :meta_description, :in_sitemap)
      end
  end
end
