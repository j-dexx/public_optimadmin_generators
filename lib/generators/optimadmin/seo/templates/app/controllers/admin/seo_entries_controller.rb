module Admin
  class SeoEntriesController < Manticore::ApplicationController

    def index
      @seo_entries = SeoEntry.order(params[:order] ||= 'nominal_url').where([
        "nominal_url LIKE :search OR title LIKE :search OR meta_description LIKE :search",
        { :search => "%#{params[:search]}%" }
      ]).page(params[:page])
    end

    def edit
      @seo_entry = SeoEntry.find(params[:id])
    end

    def update
      @seo_entry = SeoEntry.find(params[:id])
      if @seo_entry.update_attributes(params[:seo_entry])
        redirect_to admin_seo_entries_path, :notice => "Seo entry successfully updated."
      else
        render :action => 'edit'
      end
    end

    def rebuild_seo
      SEO.rebuild!
      redirect_to admin_seo_entries_path, :notice => "Seo entries rebuilt."
    end

    def seo_entry_params
      params.require(:seo_entry).permit(:title, :meta_description, :in_sitemap)
    end

  end
end
