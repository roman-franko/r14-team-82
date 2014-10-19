require 'rails_helper'

RSpec.describe Request, :type => :model do

  describe 'factory' do
    it { expect(create(:request)).to be_valid }
  end

  describe 'validations' do

    describe 'request_string' do

      context "presence" do
        let(:request) { Request.create }

        it { expect(request).not_to be_valid }

        it "isn't valid" do
          expect(request.errors.full_messages).to eq ["Request string can't be blank"]
        end
      end

    end
  end

  describe '.create_with_entities!' do
    before(:each) do
      data = {
        start_date: '2014-10-18',
        end_date: '2014-10-18',
        headline: 'C++',
        text: 'text',
        media: 'http://ex.com'
      }

      allow_any_instance_of(Request).to receive(:fetch_wiki_data).and_return(data)
    end

    it 'creates entities' do
      expect {
        Request.create_with_entities! request_string: 'C++, Ruby'
      }.to change{ Entity.count }.by(2)
    end

    it 'request has two entities' do
      request = Request.create_with_entities! request_string: 'C++, Ruby'
      expect(request.entities.size).to eq 2
    end

    it 'use exists entries' do
      FactoryGirl.create :entity, headline: 'C++'
      expect {
        Request.create_with_entities! request_string: 'C++'
      }.to change{ Entity.count }.by(0)
    end

  end
end
