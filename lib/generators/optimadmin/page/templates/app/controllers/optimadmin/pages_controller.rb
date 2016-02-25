module Optimadmin
  class PagesController < Optimadmin::ApplicationController
    before_action :set_page, only: [:show, :edit, :update, :destroy]

    edit_images_for Page, [[:image, { show: ['fit', 200, 200] }]]

    def index
      @pages = Optimadmin::BaseCollectionPresenter.new(collection: Page.where('title ILIKE ?', "#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::PagePresenter)
    end

    def show
    end

    def new
      @page = Page.new
    end

    def edit
    end

    def create
      @page = Page.new(page_params)
      if @page.save
        redirect_to_index_or_continue_editing(@page)
      else
        render :new
      end
    end

    def update
      if @page.update(page_params)
        redirect_to_index_or_continue_editing(@page)
      else
        render :edit
      end
    end

    def destroy
      @page.destroy
      redirect_to pages_url, notice: 'Page was successfully destroyed.'
    end

    private

    def set_page
      @page = Page.friendly.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :suggested_url, :image,
                                   :image_cache, :remove_image, :remote_image_url,
                                   :display, :content, :style, :layout)
    end
  end
end
