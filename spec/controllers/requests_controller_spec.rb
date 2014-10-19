require 'rails_helper'

RSpec.describe RequestsController, :type => :controller do

  describe "GET index" do
    before do
      create(:request)
      create(:request)
    end

    subject! { get :index }

    it { expect(response).to be_success }
    it { expect(JSON.parse(response.body).size).to eq 2 }
    it { expect(JSON.parse(response.body).first).to include('id') }
    it { expect(JSON.parse(response.body).first).to include('entities') }
  end

  describe "POST create" do
    context 'success' do
      it "returns http success" do
        post :create, entities: 'C++, Java, Ruby'
        expect(response).to be_success
      end

      it 'creates Request' do
        expect {
          post :create, entities: 'C++, Java, Ruby'
        }.to change{ Request.count }.by(1)
      end
    end

    context 'failure' do
      it "returns http bad_request" do
        post :create
        expect(response).to have_http_status(:bad_request)
      end

      it 'creates Request' do
        expect {
          post :create
        }.to change{ Request.count }.by(0)
      end
    end
  end

  describe "GET show" do
    context 'success' do
      subject!(:request) { create(:request) }
      before { get :show, id: request.id }

      it { expect(response).to be_success }
      it { expect(JSON.parse response.body).to include('id') }
    end

    context 'failure' do
      it "returns http not_found" do
        get :show, id: 234324
        expect(response).to have_http_status(:not_found)
      end
    end
  end

end
