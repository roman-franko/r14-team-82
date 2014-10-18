require 'rails_helper'

RSpec.describe Request, :type => :model do

  describe 'factory' do
    it { expect(create(:request)).to be_valid }
  end

  describe 'validations' do

  end
end
