require "rails_helper"

describe Optimadmin::<%= class_name.pluralize %>Controller, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when <%= human_name %> is valid" do
      it "redirects to index on normal save" do
        <%= singular_table_name %> = stub_valid_<%= singular_table_name %>

        post :create, commit: "Save", <%= singular_table_name %>: <%= singular_table_name %>.attributes

        expect(response).to redirect_to(<%= singular_table_name %>s_path)
        expect(flash[:notice]).to eq("<%= human_name %> was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        <%= singular_table_name %> = stub_valid_<%= singular_table_name %>

        post :create, commit: "Save and continue editing", <%= singular_table_name %>: <%= singular_table_name %>.attributes

        expect(response).to redirect_to(edit_<%= singular_table_name %>_path(<%= singular_table_name %>))
        expect(flash[:notice]).to eq("<%= human_name %> was successfully created.")
      end
    end

    context "when <%= human_name %> is invalid" do
      it "renders the edit template" do
        <%= singular_table_name %> = stub_invalid_<%= singular_table_name %>

        post :create, commit: "Save", <%= singular_table_name %>: <%= singular_table_name %>.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when <%= human_name %> is valid" do
      it "redirects to index on normal save" do
        <%= singular_table_name %> = stub_valid_<%= singular_table_name %>

        patch :update, id: <%= singular_table_name %>.id, commit: "Save", <%= singular_table_name %>: <%= singular_table_name %>.attributes

        expect(response).to redirect_to(<%= singular_table_name %>s_path)
        expect(flash[:notice]).to eq("<%= human_name %> was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        <%= singular_table_name %> = stub_valid_<%= singular_table_name %>

        patch :update, id: <%= singular_table_name %>.id, commit: "Save and continue editing", <%= singular_table_name %>: <%= singular_table_name %>.attributes

        expect(response).to redirect_to(edit_<%= singular_table_name %>_path(<%= singular_table_name %>))
        expect(flash[:notice]).to eq("<%= human_name %> was successfully updated.")
      end
    end

    context "when <%= human_name %> is invalid" do
      it "renders the edit template" do
        <%= singular_table_name %> = stub_invalid_<%= singular_table_name %>

        patch :update, id: <%= singular_table_name %>.id, commit: "Save", <%= singular_table_name %>: <%= singular_table_name %>.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  
  def stub_valid_<%= singular_table_name %>
    <%= singular_table_name %> = build_stubbed(:<%= singular_table_name %>)
    allow(AdditionalContent).to receive(:new).and_return(<%= singular_table_name %>)
    allow(<%= singular_table_name %>).to receive(:save).and_return(true)
    allow(AdditionalContent).to receive(:find).and_return(<%= singular_table_name %>)
    allow(<%= singular_table_name %>).to receive(:update).and_return(true)
    <%= singular_table_name %>
  end

  def stub_invalid_<%= singular_table_name %>
    <%= singular_table_name %> = build_stubbed(:<%= singular_table_name %>)
    allow(AdditionalContent).to receive(:new).and_return(<%= singular_table_name %>)
    allow(<%= singular_table_name %>).to receive(:save).and_return(false)
    allow(AdditionalContent).to receive(:find).and_return(<%= singular_table_name %>)
    allow(<%= singular_table_name %>).to receive(:update).and_return(false)
    <%= singular_table_name %>
  end
end

