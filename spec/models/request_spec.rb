require 'rails_helper'

RSpec.describe Request, :type => :model do

  describe 'factory' do
    it { expect(create(:request)).to be_valid }
  end

  describe 'validations' do

    it 'valid data' do
      expect(Request.create(text: "request text")).to be_valid
    end

    describe 'text' do

      context "presence" do
        let(:request) { Request.create }

        it { expect(request).not_to be_valid }

        it "isn't valid" do
          expect(request.errors.full_messages).to eq ["Text can't be blank"]
        end
      end

    end
  end
end
