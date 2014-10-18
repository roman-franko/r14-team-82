require 'rails_helper'

RSpec.describe Entity, :type => :model do

  describe 'factory' do
    it { expect(create(:entity)).to be_valid }
  end
end
