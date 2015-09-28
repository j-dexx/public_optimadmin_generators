require "rails_helper"

RSpec.describe PagePresenter, type: :presenter do
  let(:page) { build(:page) }
  subject(:page_presenter) { PagePresenter.new(object: page, view_template: view)}

  describe "delegations", :delegation do
    it { should delegate_method(:title).to(:page) }
  end

  describe "standard page" do
    it "returns the content - html formatted" do
      expect(page_presenter.content).to eq(raw page.content)
    end
  end

  describe "images" do
    describe "no image" do
      it "show_image should return nil" do
        expect(page_presenter.show_image).to eq(nil)
      end
    end

    describe "has image" do
      let(:page) { build(:page_with_image) }
      subject(:page_presenter) { PagePresenter.new(object: page, view_template: view)}

      it "show_image should not return nil" do
        expect(page_presenter.show_image(alt: page.title)).to eq(image_tag(page.image.show, alt: page.title))
      end
    end
  end
end
