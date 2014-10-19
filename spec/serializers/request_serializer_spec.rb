require 'rails_helper'

RSpec.describe RequestSerializer do

  context 'request entities' do
    subject(:serializer) do
      request = create(:request_with_entities)
      RequestSerializer.new request, scope: 'entities'
    end

    let(:data) do
      [
        {
          "startDate"=>'2014,10,18',
          "endDate"=>'2014,10,18',
          "headline"=>"MyString",
          "text"=>"MyText",
          "asset"=>{"media"=>"MyString", "credit"=>"", "caption"=>""}
        }
      ]
    end

    it { expect(JSON.parse serializer.as_json).to eq data }
  end

  context 'list of requests' do
    let(:request) { create(:request_with_entities) }
    subject(:serializer) { RequestSerializer.new request }

    let(:data) do
      { 'id' => request.id, 'entities' => request.entities.map(&:headline).join(', ') }
    end

    it { expect(JSON.parse serializer.to_json).to eq data }
  end
end
