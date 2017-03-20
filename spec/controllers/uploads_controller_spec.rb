# frozen_string_literal: true
require 'rails_helper'
require 'support/controller_macros'
require 'support/devise'
require 'controllers/shared_examples/shared_examples_for_authentication'

RSpec.describe UploadsController, type: :controller do
  it_behaves_like 'an authenticating controller', :index, 'uploads'

  describe 'GET index' do
    login_user

    before(:each) do
      create :upload
      get :index
    end

    it 'populates an array of uploads' do
      expect(assigns(:uploads)).to include(Upload.first)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET new' do
    login_user

    it 'assigns a blank upload record' do
      get :new
      expect(assigns(:upload)).to be_a_new(Upload)
    end

    context 'without specifying a csv_type' do
      before(:each) do
        get :new
      end

      it 'assigns a generic skip_lines' do
        expect(assigns(:upload).skip_lines).to eq(0)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'specifying a csv_type' do
      before(:each) do
        get :new, csv_type: 'Complaint'
      end

      it 'assigns skip_lines for Complaint' do
        expect(assigns(:upload).skip_lines).to eq(7)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST create' do
    let(:upload_file) { build(:upload).upload_file }
    login_user

    context 'having valid form input' do
      it 'Uploads a csv file' do
        expect do
          post :create, upload: { upload_file: upload_file, skip_lines: 0, comment: 'Test', csv_type: 'Weam' }
        end.to change(Weam, :count).by(2)
      end

      it 'redirects to show' do
        expect(
          post(:create, upload: { upload_file: upload_file, skip_lines: 0, comment: 'Test', csv_type: 'Weam' })
        ).to redirect_to(action: :show, id: assigns(:upload).id)
      end
    end

    context 'having invalid form input' do
      context 'with a non-valid csv_type' do
        it 'renders the new view' do
          expect(
            post(:create, upload: { upload_file: upload_file, skip_lines: 0, comment: 'Test', csv_type: 'Blah' })
          ).to render_template(:new)
        end
      end

      context 'with a nil upload file' do
        it 'renders the new view' do
          expect(
            post(:create, upload: { upload_file: nil, skip_lines: 0, comment: 'Test', csv_type: 'Weam' })
          ).to render_template(:new)
        end
      end
    end
  end

  describe 'GET show' do
    login_user
    let(:upload) { create :upload }

    context 'with a valid id' do
      it 'gets the upload instance' do
        get :show, id: upload.id
        expect(assigns(:upload)).to eq(upload)
      end
    end

    context 'with a invalid id' do
      it 'renders the index view' do
        expect(get(:show, id: 0)).to redirect_to(action: :index)
      end
    end
  end
end